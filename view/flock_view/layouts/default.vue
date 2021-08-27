<template>
  <v-app dark>
    <v-main>
      <v-container>
        <v-app-bar
          fixed
          app
          flat
          clipped-left
          dark
          color="#ffffff"
          >
          <v-btn to="/" text color="black">flock</v-btn>
          <v-spacer />
          <v-btn depressed dark color="blue lighten-1" to="/articles/new">投稿</v-btn>
        </v-app-bar>
        <Nuxt />
      </v-container>
    </v-main>
    <v-footer
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

<style>
.v-main__wrap{
  background-color: #FAFAFA;
}
</style>
