<template>
  <div>
    <p>{{ user.name }}</p>
  </div>
</template>

<script>
export default {
  data () {
    return {
      user: '',
    }
  },
  mounted() {
    const userUrl = '/users/' + this.$route.params.id
    this.$axios.get(userUrl)
      .then((res) => {
        this.user = res.data
      })
  }
}
</script>
