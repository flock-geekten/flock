<template>
  <v-app dark>
    <v-main>
      <v-container>
        <v-app-bar
          :clipped-left="clipped"
          fixed
          app
          flat
          color="#ffffff"
          >
          flock
        </v-app-bar>
        <Nuxt />
      </v-container>
    </v-main>
    <v-footer
      :absolute="!fixed"
      app
      >
      <span>flock &copy; {{ new Date().getFullYear() }}</span>
    </v-footer>
  </v-app>
</template>

<script>
import Menu from '../components/Menu.vue'
export default {
  components: {
    Menu
  }
}
</script>
