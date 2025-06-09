<script setup lang="ts">
//import { RouterLink, RouterView } from 'vue-router'
import { RouterView } from 'vue-router'
import { Toaster } from '@/components/ui/sonner'
import 'vue-sonner/style.css' // vue-sonner v2 requires this import
</script>

<template>
  <Toaster />
  <header>
    <!-- <div class="wrapper">
      <nav>
        <RouterLink to="/">Home</RouterLink>
        <RouterLink to="/about">About</RouterLink>
      </nav>
    </div> -->
  </header>

  <main>
    <RouterView />
  </main>
</template>
