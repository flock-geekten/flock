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
        class="my-5"
        />
      <v-textarea
        v-model="body"
        height="1200"
        label="本文"
				placeholder="# タイトル

## サブタイトル

- 箇条書き
- 箇条書き

1. 数字
2. 数字

				"
        flat
        solo
        counter
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
          @click="onSummaryFlag()"
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
        summary: '',
        keyPhrases0: '', 
        keyPhrases1: '', 
        keyPhrases2: '', 
        keyPhrases3: '', 
        keyPhrases4: '', 
      }
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
      }
    }
  }
</script>

<style>
.v-text-field.v-text-field--solo .v-input__control input{
  font-size: xx-large;
}
</style>
