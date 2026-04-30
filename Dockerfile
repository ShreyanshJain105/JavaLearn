# ================================
# JAVA CHAT - PRODUCTION DOCKERFILE
# ================================

# ---------- FRONTEND BUILD ----------
FROM node:22-bookworm-slim AS frontend-builder
WORKDIR /app/frontend

COPY frontend/package*.json ./
RUN npm ci

COPY frontend/ .
RUN npm run build


# ---------- BACKEND BUILD ----------
FROM eclipse-temurin:25-jdk AS builder
WORKDIR /app

# Gradle setup
COPY gradlew .
COPY gradle/ gradle/
RUN chmod +x gradlew

# Build config
COPY build.gradle.kts settings.gradle.kts gradle.properties ./
COPY config/ config/

# Download dependencies
RUN ./gradlew dependencies --no-daemon || true

# Source code
COPY src ./src

# ✅ FIXED COPY (VERY IMPORTANT)
COPY --from=frontend-builder /app/src/main/resources/static ./src/main/resources/static

# Build app (skip spotless)
RUN ./gradlew clean build -x test -x spotlessCheck --no-daemon && \
    cp $(ls build/libs/*.jar | grep -v '\-plain\.jar' | head -n 1) app.jar


# ---------- RUNTIME ----------
FROM eclipse-temurin:25-jre
WORKDIR /app

# Install curl
RUN apt-get update && apt-get install -y curl && rm -rf /var/lib/apt/lists/*

# Create non-root user
RUN useradd -m appuser
USER appuser

# Copy built app
COPY --from=builder /app/app.jar app.jar

# Environment defaults
ENV PORT=8085
ENV APP_LOCAL_EMBEDDING_ENABLED=false
ENV APP_LOCAL_EMBEDDING_USE_HASH_WHEN_DISABLED=true
ENV QDRANT_HOST=localhost
ENV QDRANT_PORT=6334
ENV QDRANT_REST_PORT=6333

EXPOSE 8085

# Healthcheck
HEALTHCHECK CMD curl --fail http://localhost:${PORT}/actuator/health || exit 1

# Run app
ENTRYPOINT ["sh", "-c", "java -Xms128m -Xmx256m -jar app.jar --server.port=${PORT}"]