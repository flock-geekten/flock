<template>
  <div>
    <div class="post-title">計画をたてる</div>
    <v-text-field
      v-model="title"
      label="タイトル"
      flat
      solo
      clearable
      class="mt-5"
      />
      <v-textarea
        v-model="body"
        height="300"
        label="内容"
        value="自動生成された文章を入れる"
        placeholder="日時：2021年9月19日 13:00～
場所：渋谷
人数：3人募集
                   "
        hint="時間や場所、人数を明確に記載してください。"
        flat
        solo
        class="mt-5"
        />
        <div class="text-center py-5">
          <v-btn
						v-show="title.length !== 0 && body.length !== 0"
            rounded
            depressed
            color="blue lighten-1"
            class="pa-6"
            dark
            :ripple="false"
            @click="createPlan()"
            >
            投稿
          </v-btn>
          <v-btn
						v-show="title.length === 0 || body.length === 0"
            rounded
            depressed
						disabled
            color="blue lighten-1"
            class="pa-6"
            >
            投稿
          </v-btn>
        </div>
  </div>
</template>

<script>
import axios from 'axios'
  export default {
    data () {
      return {
        title: '',
        body: "日時：2021年9月19日 13:00～\n場所：渋谷\n人数：3人募集"
      }
    },
    methods: {
      createPlan: function(){
      const createPlanUrl = this.$apiBaseUrl + '/plans'
      var params = new URLSearchParams();
      params.append('title', this.title);
      params.append('body', this.body);
      params.append('user_id', this.$store.state.user.userId);
      params.append('is_done', 1);
      axios.post(createPlanUrl, params).then(
        this.$router.push('/')
      )
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