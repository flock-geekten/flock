<template>
  <div>
    <p>{{ user }}</p>
    <p>{{ posts }}</p>
    <p>{{ likes }}</p>
  </div>
</template>

<script>
export default {
  data () {
    return {
      user: '',
      posts: '',
      likes: '',
    }
  },
  mounted() {
    const userUrl = '/users/' + this.$route.params.id
    this.$axios.get(userUrl)
      .then((res) => {
        this.user = res.data.user
        this.posts = res.data.posts
        this.likes = res.data.likes
      })
  }
}
</script>
