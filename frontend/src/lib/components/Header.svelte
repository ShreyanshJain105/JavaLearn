<script lang="ts">
  import { onMount } from 'svelte'
  import { theme } from '../stores/themeStore'

  interface Props {
    currentView: 'chat' | 'learn'
  }

  let { currentView = $bindable('chat') }: Props = $props()
</script>

<header class="header glass glass-edge">
  <div class="header-inner">
    <a href="/" class="brand" aria-label="Java Chat Home">
      <img
        class="brand-mark"
        src="/assets/javachat_cup_star_256.png"
        alt=""
        aria-hidden="true"
      />
      <span class="brand-text">Java Chat</span>
    </a>

    <div class="nav-tabs" role="tablist" aria-label="Main navigation">
      <button
        type="button"
        role="tab"
        class="nav-tab"
        class:active={currentView === 'chat'}
        aria-selected={currentView === 'chat'}
        onclick={() => currentView = 'chat'}
      >
        <svg class="nav-icon" viewBox="0 0 20 20" fill="currentColor" aria-hidden="true">
          <path fill-rule="evenodd" d="M10 2c-4.411 0-8 2.91-8 6.5 0 1.778.785 3.4 2.071 4.615l-.614 2.307a.5.5 0 0 0 .695.577l2.756-1.103A9.1 9.1 0 0 0 10 15.5c4.411 0 8-2.91 8-6.5S14.411 2 10 2Z" clip-rule="evenodd"/>
        </svg>
        <span>Chat</span>
      </button>

      <button
        type="button"
        role="tab"
        class="nav-tab"
        class:active={currentView === 'learn'}
        aria-selected={currentView === 'learn'}
        onclick={() => currentView = 'learn'}
      >
        <svg class="nav-icon" viewBox="0 0 20 20" fill="currentColor" aria-hidden="true">
          <path d="M10.75 16.82A7.462 7.462 0 0 1 15 15.5c.71 0 1.396.098 2.046.282A.75.75 0 0 0 18 15.06v-11a.75.75 0 0 0-.546-.721A9.006 9.006 0 0 0 15 3a8.963 8.963 0 0 0-4.25 1.065V16.82ZM9.25 4.065A8.963 8.963 0 0 0 5 3c-.85 0-1.673.118-2.454.339A.75.75 0 0 0 2 4.06v11a.75.75 0 0 0 .954.721A7.462 7.462 0 0 1 5 15.5c1.579 0 3.042.487 4.25 1.32V4.065Z"/>
        </svg>
        <span>Learn</span>
      </button>
    </div>

    <button
      type="button"
      class="theme-toggle"
      onclick={() => theme.toggle()}
      title="Toggle theme"
      aria-label="Toggle theme"
    >
      {#if $theme === 'dark'}
        <svg viewBox="0 0 20 20" fill="currentColor" class="theme-icon">
          <path d="M10 2a.75.75 0 0 1 .75.75v1.5a.75.75 0 0 1-1.5 0v-1.5A.75.75 0 0 1 10 2ZM10 15a.75.75 0 0 1 .75.75v1.5a.75.75 0 0 1-1.5 0v-1.5A.75.75 0 0 1 10 15ZM10 7a3 3 0 1 0 0 6 3 3 0 0 0 0-6ZM15.657 5.404a.75.75 0 1 0-1.06-1.06l-1.061 1.06a.75.75 0 0 0 1.06 1.06l1.06-1.06ZM6.464 14.596a.75.75 0 1 0-1.06-1.06l-1.06 1.06a.75.75 0 0 0 1.06 1.06l1.06-1.06ZM18 10a.75.75 0 0 1-.75.75h-1.5a.75.75 0 0 1 0-1.5h1.5A.75.75 0 0 1 18 10ZM5 10a.75.75 0 0 1-.75.75h-1.5a.75.75 0 0 1 0-1.5h1.5A.75.75 0 0 1 5 10ZM15.657 14.596a.75.75 0 1 1-1.06 1.06l-1.06-1.06a.75.75 0 1 1 1.06-1.06l1.06 1.06ZM6.464 5.404a.75.75 0 1 1-1.06 1.06l-1.061-1.06a.75.75 0 1 1 1.06-1.06l1.06 1.061Z" />
        </svg>
      {:else}
        <svg viewBox="0 0 20 20" fill="currentColor" class="theme-icon">
          <path d="M17.293 13.293A8 8 0 0 1 6.707 2.707a8.001 8.001 0 1 0 10.586 10.586Z" />
        </svg>
      {/if}
    </button>

  </div>
</header>

<style>
  .header {
    position: sticky;
    top: 0;
    z-index: 100;
    border-bottom: 1px solid var(--color-border-subtle);
  }

  .header-inner {
    display: flex;
    align-items: center;
    justify-content: space-between;
    max-width: 1400px;
    margin: 0 auto;
    padding: var(--space-3) var(--space-6);
    gap: var(--space-8);
  }

  /* Brand */
  .brand {
    display: flex;
    align-items: center;
    gap: var(--space-3);
    text-decoration: none;
    color: inherit;
    transition: opacity var(--duration-fast) var(--ease-out);
  }

  .brand:hover {
    opacity: 0.85;
  }

  .brand-mark {
    width: 32px;
    height: 32px;
    border-radius: var(--radius-md);
    object-fit: contain;
  }

  .brand-text {
    font-family: var(--font-serif);
    font-size: var(--text-lg);
    font-weight: 500;
    letter-spacing: var(--tracking-tight);
  }

  /* Navigation */
  .nav-tabs {
    display: flex;
    gap: var(--space-1);
    background: var(--color-bg-primary);
    padding: var(--space-1);
    border-radius: var(--radius-lg);
    border: 1px solid var(--color-border-subtle);
    box-shadow: inset 0 1px 2px rgba(0, 0, 0, 0.2);
  }

  .nav-tab {
    display: flex;
    align-items: center;
    gap: var(--space-2);
    padding: var(--space-2) var(--space-4);
    font-size: var(--text-sm);
    font-weight: 500;
    color: var(--color-text-secondary);
    background: transparent;
    border: none;
    border-radius: var(--radius-md);
    cursor: pointer;
    transition: all var(--duration-fast) var(--ease-out);
  }

  .nav-tab:hover:not(.active) {
    color: var(--color-text-primary);
    background: var(--color-surface-hover);
  }

  .nav-tab.active {
    color: var(--color-text-primary);
    background: var(--color-bg-elevated);
    box-shadow: var(--shadow-sm);
  }

  .nav-icon {
    width: 16px;
    height: 16px;
    opacity: 0.7;
    transition: opacity var(--duration-fast) var(--ease-out);
  }

  .nav-tab:hover .nav-icon,
  .nav-tab.active .nav-icon {
    opacity: 1;
  }

  .theme-toggle {
    display: flex;
    align-items: center;
    justify-content: center;
    width: 36px;
    height: 36px;
    border-radius: var(--radius-full);
    background: var(--color-bg-elevated);
    border: 1px solid var(--color-border-subtle);
    color: var(--color-text-secondary);
    cursor: pointer;
    transition: all var(--duration-normal) var(--ease-spring);
    box-shadow: var(--shadow-sm);
  }

  .theme-toggle:hover {
    color: var(--color-accent);
    transform: rotate(15deg) scale(1.1);
    background: var(--color-bg-hover);
    box-shadow: var(--shadow-md), var(--glow-accent);
  }

  .theme-icon {
    width: 18px;
    height: 18px;
  }


  /* Tablet */
  @media (max-width: 768px) {
    .header-inner {
      padding: var(--space-3) var(--space-4);
    }
  }

  /* Mobile */
  @media (max-width: 640px) {
    .header-inner {
      padding: var(--space-2) var(--space-3);
      gap: var(--space-3);
    }

    .brand-text {
      display: none;
    }

    .brand-mark {
      width: 36px;
      height: 36px;
    }

    .nav-tab span {
      display: none;
    }

    .nav-tab {
      padding: var(--space-2) var(--space-3);
      min-height: 44px; /* Touch target */
    }

    .nav-icon {
      width: 20px;
      height: 20px;
    }
  }

  /* Small phones */
  @media (max-width: 380px) {
    .header-inner {
      padding: var(--space-2);
      gap: var(--space-2);
    }

    .brand-mark {
      width: 32px;
      height: 32px;
    }

    .nav-tabs {
      padding: 2px;
    }

    .nav-tab {
      padding: var(--space-2);
    }
  }
</style>
