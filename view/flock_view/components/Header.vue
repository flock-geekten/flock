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
          <v-menu
            bottom
            origin="center center"
            transition="scale-transition"
            >
            <template v-slot:activator="{ on, attrs }">
              <v-btn
                color="blue ligthen-1"
                dark
                depressed
                v-bind="attrs"
                v-on="on"
              >
                メニュー
              </v-btn>
            </template>
            <v-list>
              <v-list-item to="/mypage">
                <v-list-item-title><v-icon class="mr-2">mdi-account</v-icon>{{ this.$store.state.user.userName }}</v-list-item-title>
              </v-list-item>
              <v-list-item to="/articles/new">
                <v-list-item-title><v-icon class="mr-2">mdi-note-plus-outline</v-icon>投稿</v-list-item-title>
              </v-list-item>
              <v-list-item to="/hangouts/recommend">
                <v-list-item-title><v-icon class="mr-2">mdi-play</v-icon>あそびレコメンド</v-list-item-title>
              </v-list-item>
              <v-list-item @click="logout()">
                <v-list-item-title><v-icon class="mr-2">mdi-exit-to-app</v-icon>ログアウト</v-list-item-title>
              </v-list-item>
            </v-list>
          </v-menu>
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
            this.$store.commit('user/removeUserId')
            this.$store.commit('user/removeUserName')
            this.$router.push('/logout')
          })
      }
    },
  }
</script>

