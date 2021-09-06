<template>
  <div>
    <h1 class="py-5">友達レコメンド</h1>
    <div v-for="user in users" :key="user.id" class="py-1">
      <nuxt-link :to="{ name: 'users-id', params: { id: user.id } }">{{ user.name }}</nuxt-link>
    </div>
  </div>
</template>

<script>
import axios from 'axios'
export default {
  data () {
    return {
      users: '',
    }
  },
  mounted() {
    this.$axios.get('/users', {
      headers: { 
        "Content-Type": "application/json", 
      }
    })
      .then(response => {
        this.users = response.data
      })
  }
}
</script>
