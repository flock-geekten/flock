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
          <div v-if="this.$store.state.user.uid">
            <v-btn depressed dark color="blue lighten-1" to="/articles/new">投稿</v-btn>
            <v-btn depressed dark color="blue lighten-1" to="/mypage" class="ml-3">マイページ</v-btn>
            <v-btn depressed dark color="blue lighten-1" @click="logout()" class="ml-3">ログアウト</v-btn>
          </div>
          <div v-else-if="!this.$store.state.user.uid">
            <v-btn depressed dark color="blue lighten-1" to="/login" class="ml-3">ログイン</v-btn>
          </div>
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
import firebase from '~/plugins/firebase'
import Menu from '../components/Menu.vue'

export default {
  components: {
    Menu
  },
  methods: {
    logout(){
      firebase.auth().signOut()
        .then(() => {
          this.$store.commit('user/logout')
          this.$store.commit('user/removeUid')
        })
    }
  }
}
</script>

<style>
.v-main__wrap{
  background-color: #FAFAFA;
}
</style>
