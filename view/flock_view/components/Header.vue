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
      <v-layout align-center justify-center>
        <div style="width:1000px">
          <v-row>
            <v-app-bar-nav-icon to="/"><v-img src="https://firebasestorage.googleapis.com/v0/b/flock-geekten.appspot.com/o/logo.png?alt=media&token=e300dbce-8c62-419c-a3cf-cf7ca9895323" max-width="120px" max-height="90px" /></v-app-bar-nav-icon>
            <v-spacer />
              <div v-show="this.$store.state.user.loggedIn">
                <v-menu
                  bottom
                  origin="center center"
                  transition="scale-transition"
                  >
                  <template v-slot:activator="{ on, attrs }">
                    <v-btn
                      color="blue ligthen-1"
                      dark
                      text
                      v-bind="attrs"
                      v-on="on"
                      :ripple="false"
                      >
                      <v-icon>mdi-account-circle</v-icon>
                    </v-btn>
                  </template>
                  <v-list>
                    <v-list-item to="/mypage">
                      <v-list-item-title>{{ this.$store.state.user.userName }}</v-list-item-title>
                    </v-list-item>
                    <v-list-item to="/articles/new">
                      <v-list-item-title>記事を投稿する</v-list-item-title>
                    </v-list-item>
                    <v-list-item to="/plans/new">
                      <v-list-item-title>計画をたてる</v-list-item-title>
                    </v-list-item>
                    <v-list-item to="/hangouts/recommend">
                      <v-list-item-title>あそびレコメンド</v-list-item-title>
                    </v-list-item>
                    <v-list-item @click="logout()">
                      <v-list-item-title>ログアウト</v-list-item-title>
                    </v-list-item>
                  </v-list>
                </v-menu>
              </div>
              <div v-show="!this.$store.state.user.loggedIn">
                <v-btn depressed dark color="blue lighten-1" to="/login" class="ml-3" :ripple="false">ログイン</v-btn>
              </div>
          </v-row>
        </div>
      </v-layout>
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

