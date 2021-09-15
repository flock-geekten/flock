<template>
  <v-app dark>
    <v-main>
      <div v-show="this.$route.path === '/'" class="top">
        <div style="text-align:center">
          <h1 class="top-message">Fun! Fun!! Fun!!!</h1>
          <div class="pa-1">
            <v-btn
              v-show="this.$store.state.user.loggedIn"
              to="/hangouts/recommend"
              color="white"
              depressed
              rounded
              class="pa-6 mr-3"
              :ripple="false"
              >
              あそびを探す
            </v-btn>
            <v-btn
              v-show="this.$store.state.user.loggedIn"
              to="/friends"
              color="white"
              depressed
              rounded
              class="pa-6 ml-3"
              :ripple="false"
              >
              ともだちを探す
            </v-btn>
          </div>
        </div>
      </div>
      <v-container>
        <Header />
          <v-layout align-center justify-center>
            <div style="width:1000px">
              <transition mode='in-out'>
              <Nuxt />
              </transition>
            </div>
          </v-layout>
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
.index-header {
  position: relative;
  overflow: hidden;
  min-width: 1160px;
  min-height: 400px;
}
.index-header__hello-image {
    position: center;
    z-index: -1;
    top: 0;
    left: 0;
    width: 100%;
    height: 400px;
    background-image: url("~/assets/sky.jpg");
    background-repeat: no-repeat;
    background-size: cover;
}
.index-header__slogan{
  margin-top: 40px;
  color: #2e2e3b;
  font-size: 28px;
  font-weight: 700;
  text-align: center;
}
</style>

<style>
.v-enter {
  transform: scale(0.9);
  opacity: 0.1;
}
.v-enter-to {
  opacity: 1;
}
.v-enter-active {
  transition: all 0.6s .1s ease;
}
.v-leave {
  transform: scale(0.1) translate(0%,100%);
  opacity: 1;
}
.v-leave-to {
  transform: scale(0.1) translate(0%,100%);
  opacity: 0;
}
.v-leave-active {
  transition: all 5s 0s ease;
}
.top {
  background-image:url('https://firebasestorage.googleapis.com/v0/b/flock-geekten.appspot.com/o/sky.jpg?alt=media&token=180a805e-7f24-428f-addd-de7fefcc1506');
  /* background-image:url('https://firebasestorage.googleapis.com/v0/b/flock-geekten.appspot.com/o/IMG_20200607_164538.jpg?alt=media&token=aa8532be-d6e7-4004-ae17-ac6ea1ff5424'); */
  height: 400px
}
.top-message {
  padding-top: 100px;
  font-size: 80px;
  color: #FFFFFF; 
}
</style>
