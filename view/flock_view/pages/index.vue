<template>
  <div>
    <!-- <v-row> -->
    <!--   <v-col cols="3"> -->
    <!--     <Menu /> -->
    <!--   </v-col> -->
    <!--   <v-col cols="9"> -->
      <div v-for="post in posts" :key="post.id">
        <v-row align="center" class="justify-center">
          <v-col cols="12" sm="8" md="6">
            <v-card 
              color="white" 
              flat
              :to="{
                name: 'articles-id',
                params: {
                  id: post.post.id
                }
              }"
            >
              <v-card-title>{{ post.post.title }}</v-card-title>
              <v-card-text>{{ post.summary.content }}</v-card-text>
            </v-card>
          </v-col>
        </v-row>
      </div>
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
