<script lang="ts">
  const techStack = [
    { name: 'Java 21', color: '#f8981d' },
    { name: 'Spring Boot', color: '#6db33f' },
    { name: 'Qdrant', color: '#ff4b4b' },
    { name: 'Svelte 5', color: '#ff3e00' },
    { name: 'Vite', color: '#646cff' },
    { name: 'Groq', color: '#f55036' },
    { name: 'RAG', color: '#d4a04a' }
  ]
</script>

<footer class="footer glass glass-edge">
  <div class="footer-inner">
    <div class="developer-info">
      <span class="label">Developed by</span>
      <span class="name">Shreyansh Jain</span>
    </div>

    <div class="tech-stack" aria-label="Technology Stack">
      {#each techStack as tech}
        <span class="tech-tag" style="--tag-color: {tech.color}">
          <span class="dot"></span>
          {tech.name}
        </span>
      {/each}
    </div>
  </div>
</footer>

<style>
  .footer {
    padding: var(--space-3) var(--space-6);
    margin-top: auto;
    z-index: 10;
  }

  .footer-inner {
    max-width: 1400px;
    margin: 0 auto;
    display: flex;
    align-items: center;
    justify-content: space-between;
    gap: var(--space-4);
  }

  .developer-info {
    display: flex;
    align-items: center;
    gap: var(--space-2);
    font-size: var(--text-sm);
    color: var(--color-text-secondary);
  }

  .developer-info .name {
    font-weight: 600;
    color: var(--color-accent);
    letter-spacing: var(--tracking-tight);
  }

  .tech-stack {
    display: flex;
    align-items: center;
    gap: var(--space-3);
    flex-wrap: wrap;
  }

  .tech-tag {
    display: inline-flex;
    align-items: center;
    gap: var(--space-2);
    font-size: var(--text-xs);
    font-weight: 500;
    color: var(--color-text-tertiary);
    padding: var(--space-1) var(--space-3);
    background: var(--color-bg-secondary);
    border: 1px solid var(--color-border-subtle);
    border-radius: var(--radius-full);
    transition: all var(--duration-normal) var(--ease-spring);
  }

  .tech-tag:hover {
    color: var(--color-text-primary);
    background: var(--color-bg-tertiary);
    border-color: var(--tag-color);
    transform: translateY(-2px);
    box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
  }

  .dot {
    width: 6px;
    height: 6px;
    border-radius: 50%;
    background: var(--tag-color);
    box-shadow: 0 0 8px var(--tag-color);
  }

  /* Mobile */
  @media (max-width: 768px) {
    .footer-inner {
      flex-direction: column;
      gap: var(--space-3);
      text-align: center;
    }

    .tech-stack {
      justify-content: center;
    }
  }

  @media (max-width: 640px) {
    .footer {
      padding: var(--space-4) var(--space-4);
    }
    
    .tech-tag {
      font-size: 10px;
      padding: var(--space-1) var(--space-2);
    }
  }
</style>
