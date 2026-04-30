import { writable } from 'svelte/store'

type Theme = 'light' | 'dark'

const THEME_KEY = 'java-chat-theme'

function createThemeStore() {
  const savedTheme = (typeof window !== 'undefined' ? localStorage.getItem(THEME_KEY) : 'dark') as Theme
  const { subscribe, set, update } = writable<Theme>(savedTheme || 'dark')

  return {
    subscribe,
    toggle: () => update(t => {
      const next = t === 'dark' ? 'light' : 'dark'
      if (typeof window !== 'undefined') {
        localStorage.setItem(THEME_KEY, next)
        document.documentElement.setAttribute('data-theme', next)
      }
      return next
    }),
    init: () => {
      if (typeof window !== 'undefined') {
        const t = localStorage.getItem(THEME_KEY) as Theme || 'dark'
        document.documentElement.setAttribute('data-theme', t)
        set(t)
      }
    }
  }
}

export const theme = createThemeStore()
