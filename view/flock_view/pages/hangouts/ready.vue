<template>
  <div>
    <v-card flat class="pa-15">
      <div style="text-align:center">
        <div class="post-title">設定中です</div>
        <v-progress-circular
          indeterminate
          color="blue lighten-1"
         />
      </div>
    </v-card>
  </div>
</template>

<script>
import axios from 'axios'
export default {
  data () {
    return {
      hangouts: '',
      recommendsAll: '',
    }
  },
  mounted() {
    // 全あそびの取得
    this.$axios.get('/api/v1/score/' + this.$store.state.user.userId, {
      headers: { 
        "Content-Type": "application/json", 
      }
    })
      .then(response => {
        this.hangouts = response.data
        this.hangouts = JSON.stringify(this.hangouts)
        this.hangouts = this.hangouts.replaceAll("\"", "\'")
        const recommendUrl = this.$summaryBaseUrl + '/fun_reco/'
        var params = {
          y_json: this.hangouts,
          is_sorted: 1 // ソートしたもの
        }
        axios.post(recommendUrl, params).then((res) => {
          this.recommendsAll = res.data
          for (var i=0; i<this.recommendsAll.length; i++){
            this.createResult(this.recommendsAll[i].hangout_id, this.recommendsAll[i].score)
            // 全部保存し終わってからおすすめのあそびを表示
            if ( i == this.recommendsAll.length - 1 ){
              console.log("けっこうたいへんやったけど，ほぞんおわったでー")
              this.$router.push('/')
            }
          }
        })
      })
  },
  methods: {
    // 結果をデータベースに保存
    createResult: function(hangoutId, score){
      const createResultUrl = this.$apiBaseUrl + '/api/v1/result'
      var params = new URLSearchParams();
      params.append('user_id', this.$store.state.user.userId);
      params.append('hangout_id', hangoutId);
      params.append('result', score);
      axios.post(createResultUrl, params)
    }
  }
}
</script>

<style>
.post-title{
	font-weight: bolder;
	font-size: 40px;
  margin-top: 50px;	
  margin-bottom: 50px;	
}
</style>