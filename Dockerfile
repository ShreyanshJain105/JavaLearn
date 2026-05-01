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

EXPOSE 10000

# Run app with optimized production flags
ENTRYPOINT ["java", \
  "-Xms128m", "-Xmx256m", \
  "-XX:+UseG1GC", \
  "-XX:+ExitOnOutOfMemoryError", \
  "-Djava.security.egd=file:/dev/./urandom", \
  "-Djava.awt.headless=true", \
  "-jar", "app.jar", \
  "--server.port=10000"]