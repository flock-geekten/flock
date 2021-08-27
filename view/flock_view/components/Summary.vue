<template>
  <div>
    <v-alert
      dense
      text
      type="success"
      class="pa-5"
    >こちらで内容で投稿します。よろしいですか？</v-alert>
    <br>
    <div v-if="editSummaryFlag">
      <h3>要約</h3>
      <v-sheet class="pa-10">
      <v-textarea
        v-model="summary"
        height="150"
        label="要約"
        outlined
        counter
      />
      <v-btn
        rounded
        depressed
        color="red"
        dark
        @click="editSummaryFlag=false"
      >
        完了
      </v-btn>
      </v-sheet>
    </div>
    <div v-else>
      <h3>要約</h3>
      <v-sheet class="pa-10" color="#EEEEEE">
        <p>{{ summary }}</p>
        <v-btn
          rounded
          depressed
          color="blue lighten-1"
          dark
          @click="editSummaryFlag = true"
        >
          編集
        </v-btn>
      </v-sheet>
    </div>
    <br><br>
    <v-sheet>
      <h1>{{ title }}</h1>
      <br>
      <v-divider />
      <br>
      <p>{{ body }}</p>
    </v-sheet>
    <div v-if="mode===1" class="text-center">
      <v-btn
        rounded
        depressed
        outlined
        dark
        color="red"
        @click="offSummaryFlag();onEditFlag()"
      >
        戻る
      </v-btn>
      <v-btn
        rounded
        depressed
        color="blue lighten-1"
        dark
        @click="createPost()"
      >
        投稿
      </v-btn>
    </div>
    <div v-if="mode===2" class="text-center">
      <v-btn
        rounded
        depressed
        outlined
        dark
        color="red"
        @click="offSummaryFlag();onEditFlag()"
      >
        戻る
      </v-btn>
      <v-btn
        rounded
        depressed
        color="blue lighten-1"
        dark
        @click="updatePost()"
      >
        完了
      </v-btn>
    </div>
  </div>
</template>

<script>
  import axios from 'axios'
  export default {
    props: {
      mode: Number, // 1: 新規投稿, 2: 投稿編集
      id: Number, // 0: 新規作成時, それ以外: postのid
      title: String,
      body: String,
      summary: String,
    },
    data () {
      return {
        editSummaryFlag: false,
      }
    },
    methods: {
      onEditFlag: function(){
        this.$emit('onEditFlag')
      },
      offEditFlag: function(){
        this.$emit('offEditFlag')
      },
      onSummaryFlag: function(){
        this.$emit('onSummaryFlag')
      },
      offSummaryFlag: function(){
        this.$emit('offSummaryFlag')
      },
      // 記事の投稿
      createPost: function(){
        const createPostUrl = this.$apiBaseUrl + '/posts'
        axios.defaults.headers.common['Content-Type'] = 'application/json';
        var params = new URLSearchParams();
        params.append('title', this.title);
        params.append('body', this.body);
        axios.post(createPostUrl, params).then(
          response => {
            var id = response.data.id
            this.createSummary(id, this.summary)
            this.$router.push('/articles/confirm')
          }
        )
      },
      // 要約文の作成
      createSummary: function(id, summary){
        const createSummaryUrl = this.$apiBaseUrl + '/posts/' + id + '/summaries'
        var params = new URLSearchParams();
        params.append('content', summary);
        params.append('post_id', id);
        axios.post(createSummaryUrl, params)
      },
      // 記事の編集
      updatePost: function(){
        const updatePostUrl = '/posts/' + this.id + '?title=' + this.title + '&body=' + this.body
        this.$axios.defaults.headers.common['Content-Type'] = 'application/json';
        this.$axios.put(updatePostUrl).then(
          response => {
            const updateSummaryUrl = '/posts/' + this.id + '/summaries?content=' + this.summary + '&post_id=' + this.id
            this.$axios.put(updateSummaryUrl)
            this.$router.push('/articles/confirm')
          }
        )
      }
    }
  }
</script>

<style>
p {
  white-space: pre-wrap;
}
</style>
