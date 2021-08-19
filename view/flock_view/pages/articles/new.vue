<template>
  <div v-if="summaryFlag===true">
    <Summary 
      :title="title"
      :body="body"
      :summary="summary"
      @unsetSummaryFlag="unsetSummaryFlag"
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
        @click="setSummaryFlag()"
      >
        投稿
      </v-btn>
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
      }
    },
    mounted() {
      const url = 'http://localhost:3000' + '/tags'
      axios.get(url, {
        headers: { 
          "Content-Type": "application/json", 
        }
      })
        .then(response => {
          this.tags = response.data
        })
    },
    methods: {
      // テキストの改行したときの空白を改行コードにする
      space2br: function(text){
        return text
      },
      // 確認用ページに飛ばす
      // ここに要約文が入るようにする
      setSummaryFlag: function(){
        this.summary = "ここが要約文になるよ"
        // 要約のレスポンスが返ってきたら画面遷移する
        this.summaryFlag = true
      },
      unsetSummaryFlag: function(){
        this.summaryFlag = false
      },
      createPost: function(){
        const createPostUrl = 'http://localhost:3000' + '/posts'
        axios.defaults.headers.common['Content-Type'] = 'application/json';
        var params = new URLSearchParams();
        params.append('title', this.title);
        params.append('body', this.body);
        axios.post(createPostUrl, params).then(
          response => {
            var id = response.data.id
            // this.$router.push('/articles/'+id)
            this.$router.push('/')
          }
        )
      }
    }
  }
</script>
