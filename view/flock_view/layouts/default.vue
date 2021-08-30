<template>
  <v-app dark>
    <v-main>
      <v-container>
        <Header />
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
import axios from 'axios'
import firebase from '~/plugins/firebase'
import Menu from '../components/Menu.vue'
import Header from '../components/Header.vue'

export default {
  components: {
    Menu
  },
  data () {
    return {
      user: '',
      userName: '',
    }
  },
}
</script>

<style>
.v-main__wrap{
  background-color: #FAFAFA;
}
</style>
