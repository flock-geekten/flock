<template>
  <div>
    <div v-show="summaryFlag===true">
      <Summary 
         :mode="2"
         :id="id"
         :title="title"
         :body="body"
         @onEditFlag="onEditFlag"
         @offEditFlag="offEditFlag"
         @onSummaryFlag="onSummaryFlag"
         @offSummaryFlag="offSummaryFlag"
         :summary="summary"
         :keyPhrases0="keyPhrases0"
         :keyPhrases1="keyPhrases1"
         :keyPhrases2="keyPhrases2"
         :keyPhrases3="keyPhrases3"
         :keyPhrases4="keyPhrases4"
         />
    </div>
    <div v-show="summaryFlag===false">
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
          height="1200"
          label="本文"
          value="自動生成された文章を入れる"
          flat
          solo
          counter
          class="mt-5"
          />
          <div class="text-center py-5">
        <v-btn
          rounded
          depressed
          outlined
          color="blue lighten-1"
          class="pa-6"
          dark
          :ripple="false"
          :to="{
            name: 'articles-id',
            params: {
              id: id
            }
          }"
          >
          戻る
        </v-btn>
        <v-btn
          rounded
          depressed
          color="red"
          class="pa-6"
          dark
          :ripple="false"
          @click="deleteDialog = true"
          >
          削除
        </v-btn>
        <v-btn
          rounded
          depressed
          color="blue lighten-1"
          class="pa-6"
          dark
          :ripple="false"
          @click="onSummaryFlag()"
          >
          投稿
        </v-btn>
      </div>
    </div>
    <v-dialog
      v-model="deleteDialog"
      width="500"
      >
      <v-card>
        <v-card-text>
          <div class="pt-10">
            <h2><font font-color="#ffffff">本当に削除してよろしいですか？</font></h2>
          </div>
        </v-card-text>
        <v-card-actions>
          <v-spacer></v-spacer>
          <v-btn
            color="blue"
            rounded
            depressed
            dark
            :ripple="false"
            @click="deleteDialog = false"
            >
            いいえ
          </v-btn>
          <v-btn
            color="red"
            rounded
            depressed
            dark
            :ripple="false"
            @click="destroyPost()"
            >
            はい
          </v-btn>
        </v-card-actions>
      </v-card>
    </v-dialog>
  </div>
</template>

<script>
import axios from 'axios'
import Summary from '../../../components/Summary.vue'
export default {
  components: {
    Summary
  },
  data () {
    return {
      id: '',
      title: '',
      body: '',
      summaryFlag: false,
      dialog: false,
      select: [],
      summary: '',
			keyPhrases0: '', 
			keyPhrases1: '', 
			keyPhrases2: '', 
			keyPhrases3: '', 
			keyPhrases4: '', 
      deleteDialog: false
    }
  },
  mounted() {
    const postUrl = '/api/v1/posts/' + this.$route.params.id
    this.$axios.get(postUrl, {
      headers: { 
        "Content-Type": "application/json", 
      }
    })
      .then(response => {
        this.post = response.data.post
        this.id = response.data.post.id
        this.title = response.data.post.title
        this.body = response.data.post.body
      })
  },
  methods: {
    onEditFlag: function(){
      this.editFlag = true
    },
    offEditFlag: function(){
      this.editFlag = false
    },
    onSummaryFlag: function(){
      // 要約
      const summaryUrl = this.$summaryBaseUrl + "/summary/"
      var summaryParams = { 
        "sum_count": 0,
        "text": this.body
      }
      axios.post(summaryUrl, summaryParams)
        .then(response => {
          this.summary = response.data.summary
        })
      // キーフレーズ抽出
      const keyPhraseUrl = this.$summaryBaseUrl + "/keyphrase/"
      var keyPhraseParams = { 
        "get_key_num": 5,
        "text": this.body
      }
      axios.post(keyPhraseUrl, keyPhraseParams)
        .then(response => {
					this.keyPhrases0 = response.data.keyphrase[0]
					this.keyPhrases1 = response.data.keyphrase[1]
					this.keyPhrases2 = response.data.keyphrase[2]
					this.keyPhrases3 = response.data.keyphrase[3]
					this.keyPhrases4 = response.data.keyphrase[4]
        })
      // 要約のレスポンスが返ってきたら画面遷移する
      this.scrollTop()
      this.summaryFlag = true
    },
    offSummaryFlag: function(){
      this.summaryFlag = false
    },
    // 一番上にスクロールする
    scrollTop: function(){
      window.scrollTo({
        top: 0,
        behavior: "auto"
      })
    },
    // 削除
    destroyPost: function(){
      const destroyUrl = this.$apiBaseUrl + '/posts/' + this.$route.params.id
      axios.delete(destroyUrl).then(
        this.$router.push("/")
      )
    }
  }
}
</script>

<style>
.v-text-field.v-text-field--solo .v-input__control input{
  font-size: xx-large;
}
</style>
