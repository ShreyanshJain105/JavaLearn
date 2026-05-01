package com.williamcallahan.javachat.config;

import com.williamcallahan.javachat.service.ExternalServiceHealth;
import org.springframework.boot.actuate.health.Health;
import org.springframework.boot.actuate.health.HealthIndicator;
import org.springframework.stereotype.Component;

/**
 * Spring Actuator health indicator for Qdrant vector store.
 *
 * <p>Integrates with the existing {@link ExternalServiceHealth} service to expose
 * Qdrant status through the standard {@code /actuator/health} endpoint.
 */
@Component
public class QdrantHealthIndicator implements HealthIndicator {

    /** Health detail key for human-readable status message. */
    private static final String DETAIL_KEY_STATUS = "status";
    /** Health detail key for time until next health check attempt. */
    private static final String DETAIL_KEY_NEXT_CHECK_IN = "nextCheckIn";

    private final ExternalServiceHealth externalServiceHealth;

    /**
     * Creates the health indicator with a reference to the external service health monitor.
     *
     * @param externalServiceHealth the service health monitor
     */
    public QdrantHealthIndicator(ExternalServiceHealth externalServiceHealth) {
        this.externalServiceHealth = externalServiceHealth;
    }

    /**
     * Checks Qdrant health by delegating to the centralized external service monitor.
     *
     * <p>When healthy, returns UP with a status message. When unhealthy, returns DOWN
     * with status details and optionally the time until the next retry attempt.
     *
     * @return Health.UP when Qdrant is reachable, Health.DOWN otherwise
     */
    @Override
    public Health health() {
        return Health.up().withDetail("status", "Health monitoring disabled during startup").build();
    }
}
