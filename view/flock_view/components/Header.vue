<template>
  <div>
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
          <v-btn depressed text dark color="#333333" to="/mypage" class="ml-3">
            {{ this.$store.state.user.userName }}
          </v-btn>
          <v-btn depressed dark color="blue lighten-1" to="/articles/new">投稿</v-btn>
          <v-btn depressed dark color="blue lighten-1" @click="logout()" class="ml-3">ログアウト</v-btn>
        </div>
        <div v-else-if="!this.$store.state.user.uid">
          <v-btn depressed dark color="blue lighten-1" to="/login" class="ml-3">ログイン</v-btn>
        </div>
    </v-app-bar>
  </div>
</template>

<script>
import firebase from '~/plugins/firebase'
  export default {
    methods: {
      logout(){
        firebase.auth().signOut()
          .then(() => {
            this.$store.commit('user/logout')
            this.$store.commit('user/removeUid')
            this.$store.commit('user/removeUser')
          })
      }
    },
  }
</script>

