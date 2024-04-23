import { defineConfig } from 'vite';
import react from '@vitejs/plugin-react';
import environment from './env.js';

export default defineConfig(({ command, mode }) => {
  if (command === 'serve') {
    return {
      plugins: [react()],
    };
  } else {
    // command === 'build'
    return {
      // build specific config
      plugins: [react()],
      base: environment.REACT_APP_BASE_URL,
      build: {
        outDir: '../public',
      },
    };
  }
});