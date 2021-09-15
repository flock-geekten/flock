<template>
  <div>
    <div v-show="this.$store.state.user.loggedIn === true">
      <h2 class="my-3">あそびの予定</h2>
      <Plans :plans="plans" />
    </div>
    <h2 class="pt-15 pb-5">おすすめ記事</h2>
    <v-row align="center" class="justify-center">
      <v-col cols="12" v-for="post in posts" :key="post.id">
        <v-card 
          color="white" 
          flat
          height="320"
          max-height="320"
          :to="{
               name: 'articles-id',
               params: {
               id: post.post.id
               }
               }"
          class="pa-8" 
          :ripple="false"
          >
          <v-row>
            <v-card-title><h2>{{ post.post.title | omittedText35 }}</h2></v-card-title>
          </v-row>
          <v-row>
            <v-col cols="3">
              <v-row>
                <v-img
                  class="my-3"
                  max-height="200"
                  max-width="200"
                  src="https://cdn.vuetifyjs.com/images/cards/cooking.png"
                  ></v-img>
              </v-row>
              <v-row>
<v-card-text><v-icon class="mr-1" color="pink">mdi-heart-outline</v-icon>{{ post.likes_count }}<v-icon class="ml-3 mr-1" color="orange">mdi-comment-outline</v-icon>{{ post.comments_count }}</v-card-text>
              </v-row>
            </v-col>
            <v-col cols="9">
              <v-row>
                <v-chip-group class="ml-3"><v-chip>{{ post.tags[0].name | omittedText5 }}</v-chip><v-chip>{{ post.tags[1].name | omittedText5 }}</v-chip><v-chip>{{ post.tags[2].name | omittedText5 }}</v-chip><v-chip>{{ post.tags[3].name | omittedText5 }}</v-chip><v-chip>{{ post.tags[4].name | omittedText5 }}</v-chip></v-chip-group>
              </v-row>
              <v-row>
                <v-card-text><p style="font-size:20px">{{ post.summary.content | omittedText200 }}</p></v-card-text>
              </v-row>
            </v-col>
          </v-row>
          <v-row>
            <v-col cols="12">
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
import Plans from '../components/Plans.vue'
export default {
  components: {
    Menu,
    Plans,
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
    omittedText5(text) {
     // 20文字目以降は"…"
     return text.length > 5 ? text.slice(0, 5) + "…" : text;
    },
    omittedText80(text) {
     // 80文字目以降は"…"
     return text.length > 80 ? text.slice(0, 80) + "…" : text;
    },
    omittedText35(text) {
     // 80文字目以降は"…"
     return text.length > 35 ? text.slice(0, 35) + "…" : text;
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
