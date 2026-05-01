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
RUN sed -i 's/\r$//' gradlew && \
    ./gradlew dependencies --no-daemon || true

# Source code
COPY src ./src

# Build app (skip spotless and tests)
RUN ./gradlew clean build -x test -x spotlessCheck --no-daemon && \
    cp $(ls build/libs/*.jar | grep -v '\-plain\.jar' | head -n 1) app.jar


# ---------- RUNTIME ----------
FROM eclipse-temurin:25-jre
WORKDIR /app

# Copy JAR first as root
COPY --from=builder /app/app.jar app.jar

# Setup directories and user
RUN mkdir -p logs data/snapshots data/parsed data/index && \
    useradd -m appuser && \
    chown -R appuser:appuser /app

USER appuser

EXPOSE 10000

# Final stability flags: 300MB Heap, IPv4 priority, Auto-detect PORT
ENTRYPOINT ["java", "--enable-native-access=ALL-UNNAMED", "-Xms128m", "-Xmx300m", "-XX:+UseG1GC", "-XX:+ExitOnOutOfMemoryError", "-Djava.security.egd=file:/dev/./urandom", "-Djava.net.preferIPv4Stack=true", "-jar", "app.jar"]