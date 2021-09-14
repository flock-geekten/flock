<template>
  <div>
    <h1 class="py-5" v-show="editFlag === false">{{ plan.title }}</h1>
    <h1 class="py-5" v-show="editFlag === true">
      <v-text-field
        v-model="editedTitle"
        label="タイトル"
        flat
        solo
        clearable
        class="mt-5"
        />
    </h1>
    <p><nuxt-link :to="{ name: 'users-id', params: { id: user.id } }">{{ user.name }}</nuxt-link> さんのあそびの予定</p>
      <div v-show="this.$store.state.user.userId === plan.user_id">
        <v-btn
          v-show="plan.is_done === 1"
          rounded
          depressed
          dark
          outlined
          color="green"
          :ripple="false"
          @click="donePlan()"
          >募集を閉じる
        </v-btn>
        <v-btn
          v-show="plan.is_done === 2"
          rounded
          depressed
          dark
          color="green"
          :ripple="false"
          @click="reopenPlan()"
          >募集を再開する
        </v-btn>
        <v-btn
          v-show="editFlag === false"
          rounded
          depressed
          dark
          color="grey"
          :ripple="false"
          @click="editFlagOn(plan.title, plan.body)"
          >
          編集
        </v-btn>
        <v-btn
          v-show="editFlag === true"
          rounded
          depressed
          dark
          color="red"
          :ripple="false"
          @click="destroyPlan()"
          >
          募集を削除する
        </v-btn>
      </div>
      <div v-show="this.$store.state.user.userId !== plan.user_id">
        <v-btn
          v-show="participation.is_participation===0"
          rounded
          depressed
          dark
          outlined
          color="blue"
          :ripple="false"
          @click="createParticipation()"
          >参加する
        </v-btn>
        <v-btn
          v-show="participation.is_participation===1"
          rounded
          depressed
          dark
          color="blue"
          :ripple="false"
          @click="destroyParticipation()"
          >参加取消
        </v-btn>
      </div>
      <div v-show="editFlag === false">
        <v-card
          flat
          class="mt-5 pa-5"
          height="300px"
        >
          <p>{{ plan.body }}</p>
        </v-card>
      </div>
      <div v-show="editFlag === true">
      <v-textarea
        v-model="editedBody"
        height="300"
        label="内容"
        placeholder="日時：2021年9月19日 13:00～
場所：渋谷
人数：3人募集
わいわい楽しくやりたいです！ぜひぜひ参加してください！
                   "
        hint="時間や場所、人数を明確に記載してください。"
        flat
        solo
        class="mt-5"
        />
        <v-btn
          rounded
          depressed
          dark
          color="grey"
          :ripple="false"
          @click="editFlag = false"
          >
          戻る
        </v-btn>
        <v-btn
          rounded
          depressed
          dark
          color="blue"
          :ripple="false"
          @click="updatePlan()"
          >
          編集する
        </v-btn>
      </div>
      <br>
      <h3 class=py-3>参加者</h3>
      <v-card flat class="pa-5">
        <div v-show="participations.length === 0"><h5>参加者がいません</h5></div>
        <div v-for="p in participations" :key="p.id" v-show="participations.length !== 0">
          <li><nuxt-link :to="{ name: 'users-id', params: { id: p.id } }">{{ p.name }}</nuxt-link> さん</li>
        </div>
      </v-card>
      <br>
      <PlanComments
        :comments="comments"
        :planId="plan.id"
        @reload="reload"
        />
  </div>
</template>

<script>
import PlanComments from '../../components/PlanComments.vue'
import axios from 'axios'
export default {
  components: {
    PlanComments
  },
  data () {
    return {
      plan: '',
      user: '',
      comments: '',
      participation: '',
      participations: '',
      editFlag: false,
      editedTitle: '',
      editedBody: '',
    }
  },
  mounted() {
    this.$axios.get('/plans/' + this.$route.params.id, {
      headers: { 
        "Content-Type": "application/json", 
      }
    })
      .then(response => {
        this.plan = response.data.plan
        this.user = response.data.user
        this.comments = response.data.comments
        this.participations = response.data.participations
        this.isParticipation()
      })
  },
  methods: {
    reload: function(){
      this.$axios.get('/plans/' + this.$route.params.id, {
        headers: { 
          "Content-Type": "application/json", 
        }
      })
        .then(response => {
          this.plan = response.data.plan
          this.user = response.data.user
          this.comments = response.data.comments
          this.participations = response.data.participations
        })
    },
    isParticipation: function(){
      const url = this.$apiBaseUrl + '/is_participation'
      var params = new URLSearchParams();
      params.append('user_id', this.$store.state.user.userId);
      params.append('plan_id', this.plan.id);
      axios.post(url, params)
        .then((res) => {
          this.participation = res.data
      })
    },
    // 参加
    createParticipation: function(){
      const createUrl = this.$apiBaseUrl + '/participations'
      var params = new URLSearchParams();
      params.append('user_id', this.$store.state.user.userId);
      params.append('plan_id', this.plan.id);
      axios.post(createUrl, params)
        .then((res) => {
          this.participation = res.data
          this.reload()
      })
    },
    // 参加取り消し
    destroyParticipation: function(){
      const destroyUrl = this.$apiBaseUrl + '/participations?user_id=' + this.$store.state.user.userId + '&plan_id=' + this.plan.id
      axios.delete(destroyUrl)
        .then((res) => {
          this.participation = res.data
          this.reload()
      })
    },
    // 募集終了のときはis_doneを2に
    donePlan: function(){
      const doneUrl = this.$apiBaseUrl + '/plans/' + this.plan.id + '?is_done=2'
      axios.put(doneUrl)
        .then((res) => {
          this.reload()
      })
    },
    // 募集再開のときはis_doneを1に
    reopenPlan: function(){
      const reopenUrl = this.$apiBaseUrl + '/plans/' + this.plan.id + '?is_done=1'
      axios.put(reopenUrl)
        .then((res) => {
          this.reload()
      })
    },
    // 編集モード
    editFlagOn: function(title, body){
      this.editedTitle = title
      this.editedBody = body
      this.editFlag = true
    },
    // 計画を編集する
    updatePlan: function(){
      const updateUrl = this.$apiBaseUrl + '/plans/' + this.plan.id
      var updateParams = {
        title: this.editedTitle,
        body: this.editedBody
      }
      axios.put(updateUrl, updateParams)
        .then((res) => {
          this.reload()
          this.editFlag = false
      })
    },
    // 計画を削除する
    destroyPlan: function(){
      const destroyUrl = this.$apiBaseUrl + '/plans/' + this.plan.id
      axios.delete(destroyUrl)
        .then((res) => {
          this.$router.push('/')
      })
    },
  }
}
</script>

<style>
p {
  white-space: pre-wrap;
}
</style>
