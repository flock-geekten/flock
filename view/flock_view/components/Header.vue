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
            <v-app-bar-title v-show="$device.isDesktopOrTablet"><nuxt-link to="/"><v-img src="https://firebasestorage.googleapis.com/v0/b/flock-geekten.appspot.com/o/logo.png?alt=media&token=e300dbce-8c62-419c-a3cf-cf7ca9895323" max-width="160px" /></nuxt-link></v-app-bar-title>
            <v-app-bar-title v-show="$device.isMobile"><nuxt-link to="/"><v-img src="https://firebasestorage.googleapis.com/v0/b/flock-geekten.appspot.com/o/Llogo72ppi.png?alt=media&token=fea76491-b82c-4d09-8b1b-1767609fd99b" max-width="80px" /></nuxt-link></v-app-bar-title>
            <v-spacer />
              <div v-show="this.$store.state.user.loggedIn">
                <v-menu
                  offset-y
                  bottom
                  origin="center center"
                  >
                  <template v-slot:activator="{ on, attrs }">
                    <v-btn
                      color="blue ligthen-1"
                      dark
                      text
                      fab
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
                      <v-list-item-title>あそびを探す</v-list-item-title>
                    </v-list-item>
                    <v-list-item to="/friends">
                      <v-list-item-title>友達を探す</v-list-item-title>
                    </v-list-item>
                    <v-list-item @click="logout()">
                      <v-list-item-title>ログアウト</v-list-item-title>
                    </v-list-item>
                  </v-list>
                </v-menu>
              </div>
              <div v-show="!this.$store.state.user.loggedIn">
                <v-btn depressed dark color="blue lighten-1" to="/login" class="ml-3" :ripple="false" text fab><v-icon>mdi-login</v-icon></v-btn>
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

