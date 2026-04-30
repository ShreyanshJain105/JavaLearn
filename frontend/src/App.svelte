<script lang="ts">
  import { onMount } from 'svelte'
  import Header from './lib/components/Header.svelte'
  import ChatView from './lib/components/ChatView.svelte'
  import LearnView from './lib/components/LearnView.svelte'
  import Footer from './lib/components/Footer.svelte'
  import ToastContainer from './lib/components/ToastContainer.svelte'
  import { refreshCsrfToken } from './lib/services/csrf'
  import { theme } from './lib/stores/themeStore'

  let currentView = $state<'chat' | 'learn'>('chat')

  onMount(() => {
    theme.init()
    void refreshCsrfToken()
  })
</script>

<div class="app-shell">
  <Header bind:currentView />

  <main class="main-content">
    {#if currentView === 'chat'}
      <ChatView />
    {:else}
      <LearnView />
    {/if}
  </main>

  <Footer />
  <ToastContainer />
</div>

<style>
  .app-shell {
    display: flex;
    flex-direction: column;
    height: 100vh;
    height: 100dvh;
    overflow: hidden;
  }

  .main-content {
    flex: 1;
    display: flex;
    flex-direction: column;
    overflow: hidden;
  }
</style>
