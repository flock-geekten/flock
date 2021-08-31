<template>
  <div>
    <div v-if="this.user.id &&this.$store.state.user.loggedIn">
      <v-btn
        v-if="follow===0"
        rounded
        depressed
        dark
        outlined
        color="blue"
        @click="createFollow()"
        >フォロー
      </v-btn>
      <v-btn
        v-if="follow===1"
        rounded
        depressed
        dark
        color="blue"
        @click="destroyFollow()"
        >フォローをはずす
      </v-btn>
    </div>
    
    <h1>ユーザー情報</h1>
    <p>{{ user }}</p>
    <h1>投稿情報</h1>
    <p>{{ posts }}</p>
    <h1>いいね情報</h1>
    <p>{{ likes }}</p>
    <h1>フォロー</h1>
    <p>{{ followings }}</p>
    <h1>フォロワー</h1>
    <p>{{ followers }}</p>
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
