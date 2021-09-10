<template>
  <div>
    <h1 class="py-5">管理者ページ</h1>
    {{ message }}
  </div>
</template>

<script>
import axios from 'axios'
export default {
  data () {
    return {
      hangouts: '',
      message: '',
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
        this.hangouts = JSON.stringify(this.hangouts)
        this.hangouts = this.hangouts.replaceAll("\"", "\'")
        const recommendUrl = this.$summaryBaseUrl + '/mca'
        var params = {
          playlist: this.hangouts
        }
        axios.post(recommendUrl, params).then((res) => {
          this.message = res.data
        })
        
      })
  },
}
</script>
