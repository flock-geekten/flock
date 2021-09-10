<template>
  <div>
    <h1 class="py-5">{{ this.$store.state.user.userName }} さんにおすすめのあそび</h1>
    <div v-show="recommend.length === 0">
      <div style="text-align:center">
        <v-progress-circular
          indeterminate
          color="blue lighten-1"
         />
      </div>
    </div>
    <div v-show="recommend.length !== 0">
      <div v-for="r in recommend" :key="r.hangout_id">
        <v-btn
          class="mt-5"
          to="/plans/new"
          depressed
          rounded
          dark
          color="blue lighten-1"
          >
          {{ r.fun_name }}
        </v-btn>
      </div>
    </div>
  </div>
</template>

<script>
import axios from 'axios'
export default {
  data () {
    return {
      hangouts: '',
      recommend: ['', '', '', '', ''],
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
          y_json: this.hangouts,
          is_sorted: 1
        }
        axios.post(recommendUrl, params).then((res) => {
          this.recommend = res.data.slice(0, 5)
        })
      })
  },
}
</script>
