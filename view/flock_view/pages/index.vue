<template>
  <div>
    <v-row align="center" class="justify-center">
      <v-col cols="6" v-for="post in posts" :key="post.id">
        <v-card 
          color="white" 
          flat
          height="300"
          width="500"
          max-height="300"
          max-width="500"
          :to="{
               name: 'articles-id',
               params: {
               id: post.post.id
               }
               }"
          class="pa-5"
          >
          <v-img
            max-height="150"
            max-width="500"
            src="https://cdn.vuetifyjs.com/images/cards/cooking.png"
            ></v-img>
          <v-card-title>{{ post.post.title | omittedText10 }}<v-spacer /></v-card-title>
          <v-card-text>{{ post.summary.content | omittedText140 }}</v-card-text>
          <v-card-text><v-icon class="mr-1" color="pink">mdi-heart-outline</v-icon>{{ post.likes_count }}<v-icon class="ml-3 mr-1" color="orange">mdi-comment-outline</v-icon>{{ post.comments_count }}</v-card-text>
        </v-card>
      </v-col>
    </v-row>
  </div>
</template>

<script>
import axios from 'axios'
import Menu from '../components/Menu.vue'
export default {
  components: {
    Menu
  },
  data () {
    return {
      posts: '',
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
    }
  },
  watch: {
    loggedIn: function() {
      if (this.loggedIn) {
        this.fetchContents()
      }
    }
  },
  filters: {
    omittedText140(text) {
     // 140文字目以降は"…"
     return text.length > 140 ? text.slice(0, 140) + "…" : text;
    },
    omittedText10(text) {
     // 10文字目以降は"…"
     return text.length > 10 ? text.slice(0, 10) + "…" : text;
    },
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
