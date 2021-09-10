<template>
  <div>
    <h1 class="py-5">{{ plan.title }}</h1>
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
      <v-sheet 
        class="mt-5 pa-5"
        height="300px"
      >
        <p>{{ plan.body }}</p>
      </v-sheet>
      <br>
      <h3 class=py-3>参加者</h3>
      <v-sheet class="pa-5">
        <div v-for="p in participations" :key="p.id">
          <li><nuxt-link :to="{ name: 'users-id', params: { id: p.id } }">{{ p.name }}</nuxt-link> さん</li>
        </div>
      </v-sheet>
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
      participations: ''
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
