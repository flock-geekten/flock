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
          <v-app-bar-title><v-btn to="/" text>flock</v-btn></v-app-bar-title>
          <v-spacer />
          <v-btn text>あそびを探す</v-btn>
          <v-btn text>友達を探す</v-btn>
          <v-btn text>グループを作る</v-btn>
          <v-btn outlined color="blue lighten-1" to="/articles/new">投稿</v-btn>
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
