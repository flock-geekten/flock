<template>
  <div>
    <div class="post-title">{{ this.$store.state.user.userName }} さんにおすすめのあそび</div>
    <div v-show="flag === false">
      <div style="text-align:center">
        <v-progress-circular
          indeterminate
          color="blue lighten-1"
         />
      </div>
    </div>
    <div v-show="flag === true && evaluationFlag === false">
      <v-card class="pa-5" flat>
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
        <!-- <h2 class="py-2">がおすすめされました</h2>
        <h2 class="py-2">あそんでみてはいかがですか？</h2> -->
				<h2 class="py-5">実際にあそんでみましたか？あそびを評価するとそれをもとにさらに学習されます。<br>評価とともに記事を書いてみましょう。</h2>
      <v-btn to="/review" rounded depressed :ripple="false" dark color="red lighten-1">評価する</v-btn>
      </v-card>
      <br>
      <v-btn to="/" rounded depressed :ripple="false" dark color="blue lighten-1">TOPに戻る</v-btn>
      <!-- <p>おすすめされたあそびに満足を評価すると精度が向上します</p>
      <v-btn @click="evaluationFlag = true" rounded depressed :ripple="false" dark color="red lighten-1">評価</v-btn> -->
    </div>
    <div v-show="flag === true && evaluationFlag === true">
      <v-card flat class="pa-5">
        <v-container>
          <v-row v-for="(r, index) in recommend" :key="r.hangout_id">
            <v-col cols="3">
              {{ r.fun_name }}
            </v-col>
            <v-col cols="9">
              <v-rating
                v-model="funScore[index]"
                empty-icon="mdi-heart-outline"
                full-icon="mdi-heart"
                half-icon="mdi-heart-half-full"
                background-color="red lighten-3"
                color="red"
                ></v-rating>
            </v-col>
          </v-row>
        </v-container>
      </v-card>
      <br>
      <div style="text-align:center">
      <v-btn rounded depressed dark color="blue lighten-1" :ripple="false" @click="submit()">再評価</v-btn>
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
      recommend: '',
      recommendsAll: '',
      flag: false,
      evaluationFlag: false,
      funScore: [5, 5, 5, 5, 5]
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
        const recommendUrl = this.$summaryBaseUrl + '/fun_reco/'
        var params = {
          y_json: this.hangouts,
          is_sorted: 1 // ソートしたもの
        }
        axios.post(recommendUrl, params).then((res) => {
          this.recommend = res.data.slice(0, 5)
          this.recommendsAll = res.data
          for (var i=0; i<this.recommendsAll.length; i++){
            this.createResult(this.recommendsAll[i].hangout_id, this.recommendsAll[i].score)
            // 全部保存し終わってからおすすめのあそびを表示
            if ( i == this.recommendsAll.length - 1 ){
              console.log("けっこうたいへんやったけど，ほぞんおわったでー")
              this.flag = true
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
    },
    createFun: function(hangoutId, score){
      const createFunUrl = this.$apiBaseUrl + '/api/v1/score'
      var params = new URLSearchParams();
      params.append('user_id', this.$store.state.user.userId);
      params.append('hangout_id', hangoutId);
      params.append('fun_score', score);
      axios.post(createFunUrl, params)
    },
    submit: function(){
      for (var i=0; i < this.recommend.length; i++){
        this.createFun(this.recommend[i].hangout_id, this.funScore[i])
      }
      this.$router.push("/hangouts/ready")
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