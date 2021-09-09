<template>
  <div>
    <div v-show="summaryFlag===true">
      <Summary 
         :mode="1"
         :id="0"
         :title="title"
         :body="body"
         @onEditFlag="onEditFlag"
         @offEditFlag="offEditFlag"
         @onSummaryFlag="onSummaryFlag"
         @offSummaryFlag="offSummaryFlag"
         :summary="summary"
         :keyPhrases="keyPhrases"
         />
    </div>
    <div v-show="summaryFlag===false">
      <v-sheet class="pa-15">
        <v-text-field
          v-model="title"
          label="タイトル"
          flat
          solo
          clearable
          class="mt-15"
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
      </v-sheet>
      <div class="text-center py-5">
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
  </div>
</template>

<script>
import axios from 'axios'
import Summary from '../../components/Summary.vue'
  export default {
  components: {
    Summary
  },
    data () {
      return {
        title: '',
        body: '',
        summaryFlag: false,
        dialog: false,
        select: [],
        tags: [],
        summary: '',
        keyPhrases: '',
      }
    },
    mounted() {
      const url = '/tags'
      this.$axios.get(url, {
        headers: { 
          "Content-Type": "application/json", 
        }
      })
        .then(response => {
          this.tags = response.data
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
          "sum_count": 3,
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
            this.keyPhrases = response.data.keyphrase
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
      }
    }
  }
</script>

<style>
.v-text-field.v-text-field--solo .v-input__control input{
  font-size: xx-large;
}
</style>
