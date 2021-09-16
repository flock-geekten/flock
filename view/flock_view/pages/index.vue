<template>
  <div>
    <div v-show="this.$store.state.user.loggedIn === true">
      <h2 class="my-3">あそびの予定</h2>
      <Plans :plans="plans" />
    </div>
    <h2 class="pt-15 pb-5">みんなの投稿</h2>
    <TopArticles :posts="posts" v-show="this.$device.isDesktopOrTablet" />
    <TopArticlesMobile :posts="posts" v-show="this.$device.isMobile" />
    <div style="text-align:center">
      <v-btn depressed rounded class="my-3" color="blue ligthen-1" dark @click="reload()">記事の更新</v-btn>
    </div>
  </div>
</template>

<script>
import axios from 'axios'
import Menu from '../components/Menu.vue'
import Plans from '../components/Plans.vue'
import TopArticles from '../components/TopArticles.vue'
import TopArticlesMobile from '../components/TopArticlesMobile.vue'
export default {
  components: {
    Menu,
    Plans,
    TopArticles,
    TopArticlesMobile,
  },
  data () {
    return {
      posts: '',
      plans: '',
    }
  },
  computed: {
    loggedIn() {
      return this.$store.state.user.loggedIn
    }
  },
  methods: {
    fetchContents(){
      const url = "/api/v1/posts"
      this.$axios.get(url)
        .then((res) => {
          this.posts = res.data
        })
    },
    reload: function(){
      this.$axios.get('/api/v1/posts', {
        headers: { 
          "Content-Type": "application/json", 
        }
      })
        .then(response => {
          this.posts = response.data
          this.scrollTop()
        })
    },
    // 一番上にスクロールする
    scrollTop: function(){
      window.scrollTo({
        top: 0,
        behavior: "auto"
      })
    }
  },
  watch: {
    loggedIn: function() {
      if (this.loggedIn) {
        this.fetchContents()
      }
    }
  },
  mounted() {
    if (this.$store.state.user.uid !== ''){
      const currentUserUrl = this.$apiBaseUrl + '/api/v1/current_user'
      var params = new URLSearchParams();
      params.append('uid', this.$store.state.user.uid);
      axios.post(currentUserUrl, params)
        .then((res) => {
          this.$store.commit('user/setUser', res.data[0])
        })
    }
    this.$axios.get('/api/v1/posts', {
      headers: { 
        "Content-Type": "application/json", 
      }
    })
      .then(response => {
        this.posts = response.data
      })
    this.$axios.get('/plans', {
      headers: { 
        "Content-Type": "application/json", 
      }
    })
      .then(response => {
        this.plans = response.data
      })
  }
}
</script>

<style>
bg {
  /* 画像ファイルの指定 */
  /* background-image: url(../assets/sky.jpg); */

  /* 画像を常に天地左右の中央に配置 */
  background-position: center center;

  /* 画像をタイル状に繰り返し表示しない */
  background-repeat: no-repeat;

  /* コンテンツの高さが画像の高さより大きい時、動かないように固定 */
  background-attachment: fixed;

  /* 表示するコンテナの大きさに基づいて、背景画像を調整 */
  background-size: cover;

  /* 背景画像が読み込まれる前に表示される背景のカラー */
  background-color: #464646;

}
</style>
