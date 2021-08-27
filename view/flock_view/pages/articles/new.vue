<template>
  <div>
    <v-sheet class="pa-15">
    <div v-if="summaryFlag">
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
        />
    </div>
    <div v-else>
      <h1>記事の投稿</h1>
      <v-text-field
        v-model="title"
        label="タイトル"
        outlined
        clearable
        class="mt-15"
      />
      <v-textarea
        v-model="body"
        height="500"
        label="本文"
        value="自動生成された文章を入れる"
        outlined
        counter
        class="mt-5"
      />
      <v-combobox
        v-model="select"
        :items="tags"
        item-text="name"
        item-value="id"
        label="タグ"
        multiple
        outlined
        chips
        class="mt-5"
      />
      <div class="text-center">
        <v-btn
          rounded
          depressed
          color="blue lighten-1"
          class="pa-6"
          dark
          @click="onSummaryFlag()"
        >
          投稿
        </v-btn>
      </div>
    </div>
    </v-sheet>
  </div>
</template>

<script>
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
        summary: ''
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
        const summaryUrl = this.$summaryBaseUrl + "/2/" + this.body
        this.$axios.get(summaryUrl, {
          headers: { 
            "Content-Type": "application/json", 
          }
        })
          .then(response => {
            this.summary = response.data
        })
        // 要約のレスポンスが返ってきたら画面遷移する
        this.summaryFlag = true
      },
      offSummaryFlag: function(){
        this.summaryFlag = false
      },
    }
  }
</script>
