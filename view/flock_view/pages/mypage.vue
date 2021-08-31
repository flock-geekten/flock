<template>
  <div>
    <h1>ユーザー情報</h1>
    <p>{{ currentUser }}</p>
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
