package com.williamcallahan.javachat.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Random;

/**
 * A dummy embedding client that generates deterministic pseudo-random embeddings using the input text's hash.
 * 
 * <p>This is strictly for local development and testing when a real embedding server is unavailable.</p>
 */
public class HashEmbeddingClient implements EmbeddingClient {

    private final int dimensions;

    public HashEmbeddingClient(int dimensions) {
        if (dimensions <= 0) {
            throw new IllegalArgumentException("dimensions must be positive");
        }
        this.dimensions = dimensions;
    }

    @Override
    public List<float[]> embed(List<String> texts) {
        if (texts == null || texts.isEmpty()) {
            return List.of();
        }
        
        List<float[]> embeddings = new ArrayList<>(texts.size());
        for (String text : texts) {
            embeddings.add(generateHashVector(text));
        }
        return embeddings;
    }

    @Override
    public int dimensions() {
        return dimensions;
    }

    private float[] generateHashVector(String text) {
        float[] vector = new float[dimensions];
        if (text == null || text.isBlank()) {
            return vector;
        }
        
        long seed = text.hashCode();
        Random random = new Random(seed);
        
        for (int i = 0; i < dimensions; i++) {
            vector[i] = (random.nextFloat() * 2.0f) - 1.0f;
        }
        
        float sumOfSquares = 0.0f;
        for (int i = 0; i < dimensions; i++) {
            sumOfSquares += vector[i] * vector[i];
        }
        
        if (sumOfSquares > 0) {
            float magnitude = (float) Math.sqrt(sumOfSquares);
            for (int i = 0; i < dimensions; i++) {
                vector[i] = vector[i] / magnitude;
            }
        }
        
        return vector;
    }
}
