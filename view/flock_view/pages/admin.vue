<template>
  <div>
    <h1 class="py-5">管理者ページ</h1>
    <div v-show="flag===false">
      <v-text-field
        v-model="password"
        label="password"
        :type="'password'"
        outlined
        ></v-text-field>
      <v-btn @click="authenticate()" depressed color="blue" dark class="my-5">俺が管理者じゃ</v-btn>
      <p>{{ confirm_message }}</p>
    </div>
    <div v-show="flag===true">
      <p>{{ addMessage }}</p>
      <p>{{ message }}</p>
      <v-btn class="my-5" @click="reloadAll()" depressed dark color="green">Reload</v-btn>
      <div v-show="createHangoutFlag === false">
        <v-btn @click="createHangoutFlag = true" depressed dark color="blue">あそびを追加する</v-btn>
        <v-simple-table 
          class="mt-5"
          fixed-header
          text-center
          height="500px"
          >
          <template v-slot:default>
            <thead>
            <tr>
              <th class="text-center">ID</th>
              <th class="text-center">名前</th>
              <th class="text-center">手軽さ</th>
              <th class="text-center">少人数</th>
              <th class="text-center">大人数</th>
              <th class="text-center">室内</th>
              <th class="text-center">室外</th>
              <th class="text-center">夏</th>
              <th class="text-center">冬</th>
              <th class="text-center">家の敷地内</th>
              <th class="text-center">街</th>
              <th class="text-center">山辺</th>
              <th class="text-center">海辺</th>
              <th class="text-center">のんびり</th>
              <th class="text-center">ワイワイ</th>
              <th class="text-center">絶叫</th>
              <th class="text-center">動かない</th>
              <th class="text-center">動く</th>
              <th class="text-center">運動</th>
              <th class="text-center">オンライン可</th>
              <th class="text-center">0~2000円</th>
              <th class="text-center">2000~4000円</th>
              <th class="text-center">4000~6000円</th>
              <th class="text-center">6000~8000円</th>
              <th class="text-center">8000~10000円</th>
              <th class="text-center">10000円~</th>
            </tr>
            </thead>
            <tbody>
            <tr v-for="hangout in hangouts" :key=hangout.id>
              <td>{{ hangout.id }}</td>
              <td>{{ hangout.name }}</td>
              <td>{{ hangout.easy_week }}</td>
              <td>{{ hangout.small_group }}</td>
              <td>{{ hangout.large_group }}</td>
              <td>{{ hangout.indoor }}</td>
              <td>{{ hangout.outdoor }}</td>
              <td>{{ hangout.summer }}</td>
              <td>{{ hangout.winter }}</td>
              <td>{{ hangout.house }}</td>
              <td>{{ hangout.town }}</td>
              <td>{{ hangout.mountain }}</td>
              <td>{{ hangout.sea }}</td>
              <td>{{ hangout.nonbiri }}</td>
              <td>{{ hangout.waiwai }}</td>
              <td>{{ hangout.scream }}</td>
              <td>{{ hangout.dont_move }}</td>
              <td>{{ hangout.move }}</td>
              <td>{{ hangout.exercise }}</td>
              <td>{{ hangout.online }}</td>
              <td>{{ hangout.to_2000yen }}</td>
              <td>{{ hangout.to_4000yen }}</td>
              <td>{{ hangout.to_6000yen }}</td>
              <td>{{ hangout.to_8000yen }}</td>
              <td>{{ hangout.to_10000yen }}</td>
              <td>{{ hangout.over_10000yen }}</td>
            </tr>
            </tbody>
          </template>
        </v-simple-table>
      </div>
      <div v-show="createHangoutFlag === true">
        <h2>あそびを追加する</h2>
        <v-text-field
          v-model="name"
          label="あそび名"
          outlined
        ></v-text-field>
        <v-switch
          v-model="easy_week"
          label="手軽さ(週1以上可)"
          inset
        ></v-switch>
        <v-switch
          v-model="small_group"
          label="少人数(4人以下)"
          inset
        ></v-switch>
        <v-switch
          v-model="large_group"
          label="大人数(5人以下)"
          inset
        ></v-switch>
        <v-switch
          v-model="indoor"
          label="室内"
          inset
        ></v-switch>
        <v-switch
          v-model="outdoor"
          label="室外"
          inset
        ></v-switch>
        <v-switch
          v-model="summer"
          label="夏"
          inset
        ></v-switch>
        <v-switch
          v-model="winter"
          label="冬"
          inset
        ></v-switch>
        <v-switch
          v-model="house"
          label="家の敷地内"
          inset
        ></v-switch>
        <v-switch
          v-model="town"
          label="街"
          inset
        ></v-switch>
        <v-switch
          v-model="mountain"
          label="山辺"
          inset
        ></v-switch>
        <v-switch
          v-model="sea"
          label="海辺"
          inset
        ></v-switch>
        <v-switch
          v-model="nonbiri"
          label="のんびり"
          inset
        ></v-switch>
        <v-switch
          v-model="waiwai"
          label="ワイワイ"
          inset
        ></v-switch>
        <v-switch
          v-model="scream"
          label="絶叫"
          inset
        ></v-switch>
        <v-switch
          v-model="dont_move"
          label="動かない"
          inset
        ></v-switch>
        <v-switch
          v-model="move"
          label="動く"
          inset
        ></v-switch>
        <v-switch
          v-model="exercise"
          label="運動"
          inset
        ></v-switch>
        <v-switch
          v-model="online"
          label="オンライン可"
          inset
        ></v-switch>
        <v-switch
          v-model="to_2000yen"
          label="0~2000円"
          inset
        ></v-switch>
        <v-switch
          v-model="to_4000yen"
          label="2000円~4000円"
          inset
        ></v-switch>
        <v-switch
          v-model="to_6000yen"
          label="4000円~6000円"
          inset
        ></v-switch>
        <v-switch
          v-model="to_8000yen"
          label="6000円~8000円"
          inset
        ></v-switch>
        <v-switch
          v-model="over_10000yen"
          label="10000円~"
          inset
        ></v-switch>
        <v-btn @click="createHangoutFlag = false" depressed >やっぱやめとく</v-btn>
        <v-btn @click="createHangout()" depressed color="blue" dark class="my-5">あそびを追加する</v-btn>
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
      message: '',
      password: '',
      password_correct: 'hangout-flock',
      confirm_message: '',
      flag: false,
      createHangoutFlag: false,
      name: '',
      easy_week: false,
      small_group: false,
      large_group: false,
      indoor: false,
      outdoor: false,
      summer: false,
      winter: false,
      house: false,
      town: false,
      mountain: false,
      sea: false,
      nonbiri: false,
      waiwai: false,
      scream: false,
      dont_move: false,
      move: false,
      exercise: false,
      online: false,
      to_2000yen: false,
      to_4000yen: false,
      to_6000yen: false,
      to_8000yen: false,
      to_10000yen: false,
      over_10000yen: false,
      recommendsAll: '',
      addMessage: '',
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
        var hangouts_string
        hangouts_string = JSON.stringify(this.hangouts)
        hangouts_string = hangouts_string.replaceAll("\"", "\'")
        const recommendUrl = this.$summaryBaseUrl + '/mca/'
        var params = {
          playlist: hangouts_string
        }
        axios.post(recommendUrl, params).then((res) => {
          if (res.data.status === "OK"){
            this.message = "あそびの同期が完了したで"
          }else{
            this.message = "「あそびの同期に失敗したわ，わいには原因がわからへん．少し旅に出るわ．探さんとって．」"
          }
        })
        
      })
  },
  filters: {
    to01(item){
      if (item===true){
        return 1
      }else{
        return 0
      }
    }
  },
  methods: {
    authenticate: function(){
      if(this.password === this.password_correct){
        this.flag = true
      }else{
        this.confirm_message = "お前だれやねん！パスワード全然ちゃうぞ，出直してこい！"
      }
    },
    reload: function(){
    this.$axios.get('/hangouts', {
      headers: { 
        "Content-Type": "application/json", 
      }
    })
      .then(response => {
        this.hangouts = response.data
        var hangouts_string
        hangouts_string = JSON.stringify(this.hangouts)
        hangouts_string = hangouts_string.replaceAll("\"", "\'")
        const recommendUrl = this.$summaryBaseUrl + '/mca/'
        var params = {
          playlist: hangouts_string
        }
        axios.post(recommendUrl, params).then((res) => {
          if (res.data.status === "OK"){
            this.message = "あそびの同期が完了したで"
          }else{
            this.message = "「あそびの同期に失敗したわ，わいには原因がわからへん．少し旅に出るわ．探さんとって．」"
          }
        })
        
      })
    },
    createHangout: function(){
      const createHangoutUrl = this.$apiBaseUrl + '/hangouts'
      var params = new URLSearchParams();
      params.append('name', this.name);
      params.append('easy_week', this.easy_week | this.to01);
      params.append('small_group', this.small_group | this.to01);
      params.append('large_group', this.large_group | this.to01);
      params.append('indoor', this.indoor | this.to01);
      params.append('outdoor', this.outdoor | this.to01);
      params.append('summer', this.summer | this.to01);
      params.append('winter', this.winter | this.to01);
      params.append('house', this.house | this.to01);
      params.append('town', this.town | this.to01);
      params.append('mountain', this.mountain | this.to01);
      params.append('sea', this.sea | this.to01);
      params.append('nonbiri', this.nonbiri | this.to01);
      params.append('waiwai', this.waiwai | this.to01);
      params.append('scream', this.scream | this.to01);
      params.append('dont_move', this.dont_move | this.to01);
      params.append('move', this.move | this.to01);
      params.append('exercise', this.exercise | this.to01);
      params.append('online', this.online | this.to01);
      params.append('to_2000yen', this.to_2000yen | this.to01);
      params.append('to_4000yen', this.to_4000yen | this.to01);
      params.append('to_6000yen', this.to_6000yen | this.to01);
      params.append('to_8000yen', this.to_8000yen | this.to01);
      params.append('to_10000yen', this.to_10000yen | this.to01);
      params.append('over_10000yen', this.over_10000yen | this.to01);
      axios.post(createHangoutUrl, params).then((res) => {
        this.hangouts = res.data
        this.addMessage = this.name + "を追加したったで，意外としんどいねんから頼むわー",
        this.reloadAll()
      })
    },
    // ユーザーのあそびのスコアを計算して保存
    getUserHangoutScore: function(userId){
      this.$axios.get('/api/v1/score/' + userId, {
        headers: { 
          "Content-Type": "application/json", 
        }
      })
        .then(response => {
          var userHangouts
          userHangouts = response.data
          userHangouts = JSON.stringify(userHangouts)
          userHangouts = userHangouts.replaceAll("\"", "\'")
          const recommendUrl = this.$summaryBaseUrl + '/fun_reco/'
          var params = {
            y_json: userHangouts,
            is_sorted: 1 // ソートしたもの
          }
          axios.post(recommendUrl, params).then((res) => {
            this.recommendsAll = res.data
            for (var i=0; i<this.recommendsAll.length; i++){
              this.createResult(this.recommendsAll[i].hangout_id, this.recommendsAll[i].score, userId)
            }
          })
        })
    },
    // あそびのレコメンド結果を保存
    createResult: function(hangoutId, score, userId){
      const createResultUrl = this.$apiBaseUrl + '/api/v1/result'
      var params = new URLSearchParams();
      params.append('user_id', userId);
      params.append('hangout_id', hangoutId);
      params.append('result', score);
      axios.post(createResultUrl, params)
    },
    // すべてのユーザーのあそびの情報を取得しなおす
    reloadAll: function(){
      this.$axios.get('/users', {
      headers: { 
        "Content-Type": "application/json", 
      }
    })
      .then(response => {
        var users
        var count = 0
        users = response.data
        for ( const user of users ){
          this.getUserHangoutScore(user.id)
          count += 1
          if (users.length === count){
            this.reload()
            this.createHangoutFlag = false
            this.scrollTop()
          }
        }
      })
    },
    // 一番上にスクロールする
    scrollTop: function(){
      window.scrollTo({
        top: 0,
        behavior: "auto"
      })
    }
  }
}
</script>

<style scoped>
.v-data-table > .v-data-table__wrapper > table {
  width: 2500px;
  text-align: center
}
</style>
