<template>
  <div>
    <h1 class="ma-5">
      {{ currentUser.name }}
    </h1>
    <br>
    <v-card flat>
      <v-toolbar
        color="white"
        flat
        >
        <template v-slot:extension>
          <v-tabs
            v-model="tab"
            align-with-title
            >
            <v-tabs-slider color="blue"></v-tabs-slider>

            <v-tab
              v-for="item in items"
              :key="item"
              >
              {{ item }}
            </v-tab>
          </v-tabs>
        </template>
      </v-toolbar>

      <v-tabs-items v-model="tab">

        <!-- 投稿情報 -->
        <v-tab-item>
          <v-card flat>
            <v-card-text>
              <div v-for="post in posts" :key="post.id">
                <v-card 
                   flat 
                   color="grey lighten-3" 
                   class="px-5"
                   :to="{
                        name: 'articles-id',
                        params: {
                        id: post.post.id
                        }
                        }"
                   >
                   {{ post.summary.content }}
                </v-card>
                  <br>
              </div>
            </v-card-text>
          </v-card>
        </v-tab-item>

        <!-- いいね情報 -->
        <v-tab-item>
          <v-card flat>
            <v-card-text>
              <div v-for="like in likes" :key="like.id">
                <v-card 
                   flat 
                   color="grey lighten-3" 
                   class="pa-5"
                   :to="{
                        name: 'articles-id',
                        params: {
                        id: like.post.id
                        }
                        }"
                   >
                   {{ like.summary.content }}
                </v-card>
                  <br>
              </div>
            </v-card-text>
          </v-card>
        </v-tab-item>

        <!-- フォロー情報 -->
        <v-tab-item>
          <v-card flat class="px-10 pt-5">
            <div v-for="following in followings" :key="following.id">
              <p><nuxt-link :to="{ name: 'users-id', params: { id: following.id } }">{{ following.name }}</nuxt-link></p>
            </div>
          </v-card>
        </v-tab-item>

        <!-- フォロワー情報 -->
        <v-tab-item>
          <v-card flat class="px-10 pt-5">
            <div v-for="follower in followers" :key="follower.id">
              <p><nuxt-link :to="{ name: 'users-id', params: { id: follower.id } }">{{ follower.name }}</nuxt-link></p>
            </div>
          </v-card>
        </v-tab-item>

      </v-tabs-items>
    </v-card>
  </div>
</template>

<script>
import axios from 'axios'
import firebase from '~/plugins/firebase'

export default {
  data: () => {
    return {
      message: '',
      currentUser: '',
      posts: '',
      likes: '',
      followings: '',
      followers: '',
      tab: null,
      items: [
        '投稿', 'いいね', 'フォロー', 'フォロワー',
      ],
    }
  },

  mounted() {
    this.message = firebase.auth()
    if (this.$store.state.user.uid !== ''){
      const currentUserUrl = this.$apiBaseUrl + '/api/v1/current_user'
      var params = new URLSearchParams();
      params.append('uid', this.$store.state.user.uid);
      axios.post(currentUserUrl, params)
        .then((res) => {
          this.currentUser = res.data.user
          this.posts = res.data.posts
          this.likes = res.data.likes
          this.followings = res.data.followings
          this.followers = res.data.followers
        })
    }
  }
}
</script>
