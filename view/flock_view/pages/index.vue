<template>
  <div>
    <v-row align="center" class="justify-center">
      <div class="pa-10">
        <v-btn
          v-show="this.$store.state.user.loggedIn"
          to="/hangouts/recommend"
          color="blue lighten-1"
          dark
          depressed
          rounded
          class="pa-8"
          :ripple="false"
        >
          あそびを探す
        </v-btn>
      </div>

      <v-col cols="12" v-for="post in posts" :key="post.id">
        <v-card 
          color="white" 
          flat
          height="350"
          max-height="800"
          :to="{
               name: 'articles-id',
               params: {
               id: post.post.id
               }
               }"
          class="pa-5" 
          :ripple="false"
          >
          <v-row>
            <v-col cols="3">
              <v-img
                max-height="300"
                max-width="300"
                src="https://cdn.vuetifyjs.com/images/cards/cooking.png"
                ></v-img>
            </v-col>
            <v-col cols="9">
              <v-card-title>{{ post.post.title | omittedText20 }}</v-card-title>
              <v-card-text>{{ post.summary.content | omittedText200 }}</v-card-text>
            </v-col>
          </v-row>
          <v-row>
            <v-col cols="12">
              <v-chip>{{ post.tags[0].name | omittedText20 }}</v-chip> <v-chip>{{ post.tags[1].name | omittedText20 }}</v-chip> <v-chip>{{ post.tags[2].name | omittedText20 }}</v-chip><v-spacer /><v-card-text><v-icon class="mr-1" color="pink">mdi-heart-outline</v-icon>{{ post.likes_count }}<v-icon class="ml-3 mr-1" color="orange">mdi-comment-outline</v-icon>{{ post.comments_count }}</v-card-text>
            </v-col>
          </v-row>
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
    omittedText200(text) {
     // 200文字目以降は"…"
     return text.length > 200 ? text.slice(0, 200) + "…" : text;
    },
    omittedText20(text) {
     // 20文字目以降は"…"
     return text.length > 20 ? text.slice(0, 20) + "…" : text;
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
