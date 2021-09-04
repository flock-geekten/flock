<template>
  <div>
    <h1 class="py-5">あそびレコメンド</h1>
    <div v-for="hangout in hangouts" :key="hangout.id" class="py-1">
      <v-chip color="gray"># {{ hangout.name }}</v-chip>
    </div>
  </div>
</template>

<script>
import axios from 'axios'
export default {
  data () {
    return {
      hangouts: '',
    }
  },
  mounted() {
    this.$axios.get('/hangouts', {
      headers: { 
        "Content-Type": "application/json", 
      }
    })
      .then(response => {
        this.hangouts = response.data
      })
  }
}
</script>
