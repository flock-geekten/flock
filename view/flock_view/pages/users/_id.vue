<template>
  <div>
    <h1 class="my-5">
      {{ user.name }}
    </h1>
    <p>{{ user.profile }}</p>
    <div v-show="this.user.id !== this.$store.state.user.userId && this.$store.state.user.loggedIn">
      <v-btn
        v-show="follow===0"
        rounded
        depressed
        dark
        outlined
        color="blue"
        :ripple="false"
        @click="createFollow()"
        >フォロー
      </v-btn>
      <v-btn
        v-show="follow===1"
        rounded
        depressed
        dark
        color="blue"
        :ripple="false"
        @click="destroyFollow()"
        >フォローをはずす
      </v-btn>
    </div>
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
                   class="pa-5"
                   :ripple="false"
                   :to="{
                        name: 'articles-id',
                        params: {
                        id: post.post.id
                        }
                        }"
                   >
                  <v-card-title>{{ post.post.title }}<v-spacer /><v-icon class="mr-1" color="pink">mdi-heart-outline</v-icon>{{ post.likes_count }}<v-icon class="ml-3 mr-1" color="orange">mdi-comment-outline</v-icon>{{ post.comments_count }}</v-card-title>
                   <v-card-text>{{ post.summary.content }}</v-card-text>
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
                  <v-card-title>{{ like.post.title }}<v-spacer /><v-icon class="mr-1" color="pink">mdi-heart-outline</v-icon>{{ like.likes_count }}<v-icon class="ml-3 mr-1" color="orange">mdi-comment-outline</v-icon>{{ like.comments_count }}</v-card-title>
                   <v-card-text>{{ like.summary.content }}</v-card-text>
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
              <nuxt-link :to="{ name: 'users-id', params: { id: following.id } }">{{ following.name }}</nuxt-link>
            </div>
          </v-card>
        </v-tab-item>

        <!-- フォロワー情報 -->
        <v-tab-item>
          <v-card flat class="px-10 pt-5">
            <div v-for="follower in followers" :key="follower.id">
              <nuxt-link :to="{ name: 'users-id', params: { id: follower.id } }">{{ follower.name }}</nuxt-link>
            </div>
          </v-card>
        </v-tab-item>

      </v-tabs-items>
    </v-card>
  </div>
</template>

<script>
import axios from 'axios'
export default {
  data () {
    return {
      user: '',
      posts: '',
      likes: '',
      follow: '',
      followings: '',
      followers: '',
      tab: null,
      items: [
        '投稿', 'いいね', 'フォロー', 'フォロワー',
      ],
    }
  },
  mounted() {
    const userUrl = '/users/' + this.$route.params.id
    this.$axios.get(userUrl)
      .then((res) => {
        this.user = res.data.user
        this.posts = res.data.posts
        this.likes = res.data.likes
        this.followings = res.data.followings
        this.followers = res.data.followers
        this.isFollow()
      })
  },
  methods: {
    isFollow: function(){
      const isFollowUrl = this.$apiBaseUrl + '/is_follow'
      var params = new URLSearchParams();
      params.append('user_id', this.$store.state.user.userId);
      params.append('target_user_id', this.user.id);
      axios.post(isFollowUrl, params)
        .then((res) => {
          this.follow = res.data.is_follow
        })
    },
    createFollow: function(){
      const followUrl = this.$apiBaseUrl + '/follow'
      var params = new URLSearchParams();
      params.append('user_id', this.$store.state.user.userId);
      params.append('following_id', this.user.id);
      axios.post(followUrl, params)
        .then((res) => {
          this.follow = res.data.is_follow
        })
    },
    destroyFollow: function(){
      const unFollowUrl = this.$apiBaseUrl + '/unfollow?user_id=' + this.$store.state.user.userId + '&following_id=' + this.user.id
      axios.delete(unFollowUrl)
        .then((res) => {
          this.follow = res.data.is_follow
        })
    },
  }
}
</script>
