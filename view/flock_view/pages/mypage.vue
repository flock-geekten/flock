<template>
  <div>
    <p>{{ currentUser }}</p>
    <p>{{ posts }}</p>
    <p>{{ likes }}</p>
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
        })
    }
  }
}
</script>
