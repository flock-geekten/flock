<template>
  <v-app dark>
    <v-main>
      <div v-if="this.$route.path === '/'" class="index-header">
        <div class="index-header__hello-image">
        </div>
      </div>
      <v-container>
        <Header />
        <v-layout align-center justify-center>
          <div style="width:800px">
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
</style>
