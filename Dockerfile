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

# Build app (skip spotless and tests)
RUN ./gradlew clean build -x test -x spotlessCheck --no-daemon && \
    cp $(ls build/libs/*.jar | grep -v '\-plain\.jar' | head -n 1) app.jar


# ---------- RUNTIME ----------
FROM eclipse-temurin:25-jre
WORKDIR /app

# Install curl
RUN apt-get update && apt-get install -y curl && rm -rf /var/lib/apt/lists/*

# Create directories and non-root user
RUN mkdir -p logs data/snapshots data/parsed data/index && \
    useradd -m appuser && \
    chown -R appuser:appuser /app

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
ENV DOCS_SNAPSHOT_DIR=/app/data/snapshots
ENV DOCS_PARSED_DIR=/app/data/parsed
ENV DOCS_INDEX_DIR=/app/data/index

EXPOSE 10000

# Healthcheck
HEALTHCHECK --interval=30s --timeout=10s --start-period=60s --retries=3 \
    CMD curl -f http://localhost:${PORT:-10000}/actuator/health || exit 1

# Run app with critical flags for Qdrant/Netty performance
ENTRYPOINT ["sh", "-c", "java \
  -XX:+IgnoreUnrecognizedVMOptions \
  --enable-native-access=ALL-UNNAMED \
  --sun-misc-unsafe-memory-access=allow \
  -Xms128m -Xmx256m \
  -XX:+UseStringDeduplication \
  -XX:+ExitOnOutOfMemoryError \
  -Djava.security.egd=file:/dev/./urandom \
  -jar app.jar --server.port=${PORT:-10000}"]