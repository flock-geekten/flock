<template>
  <div>
    <h1 class="py-5">あそびレコメンド</h1>
    <div v-for="r in recommend" :key="r.hangout_id">
      {{ r }}
    </div>
  </div>
</template>

<script>
import axios from 'axios'
export default {
  data () {
    return {
      hangouts: '',
      recommend: '',
    }
  },
  mounted() {
    this.$axios.get('/api/v1/score/' + this.$store.state.user.userId, {
      headers: { 
        "Content-Type": "application/json", 
      }
    })
      .then(response => {
        this.hangouts = response.data
        this.hangouts = JSON.stringify(this.hangouts)
        this.hangouts = this.hangouts.replaceAll("\"", "\'")
        const recommendUrl = this.$summaryBaseUrl + '/fun_reco'
        var params = {
          y_json: this.hangouts
        }
        axios.post(recommendUrl, params).then((res) => {
          this.recommend = res.data.sort()
        })
      })
  },
}
</script>
