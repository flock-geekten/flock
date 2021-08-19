<template>
  <div>
    <v-alert
      dense
      text
      type="success"
    >こちらで内容で投稿します。よろしいですか？</v-alert>
    <div v-if="editSummaryFlag===true">
      <v-sheet elevation="1" class="pa-10">
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
        @click="editSummaryFlag = false"
      >
        完了
      </v-btn>
      </v-sheet>
    </div>
    <div v-else>
      <v-sheet elevation="1" class="pa-10">
        <h3>要約</h3>
        <v-divider />
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
    <br>
    <v-sheet>
      <h1>{{ title }}</h1>
      <br>
      <v-divider />
      <br>
      <p>{{ body }}</p>
    </v-sheet>
    <div class="text-center">
      <v-btn
        rounded
        depressed
        outlined
        dark
        color="red"
        class="pa-6"
        @click="unsetSummaryFlag()"
      >
        戻る
      </v-btn>
      <v-btn
        rounded
        depressed
        color="blue lighten-1"
        class="pa-6"
        dark
        @click="createPost()"
      >
        投稿
      </v-btn>
    </div>
  </div>
</template>

<script>
import axios from 'axios'
  export default {
    props: {
      title: String,
      body: String,
      summary: String,
    },
    data () {
      return {
        editSummaryFlag: false
      }
    },
    methods: {
      unsetSummaryFlag: function(){
        this.$emit('unsetSummaryFlag')
      },
      changeEditSummaryFlag: function(){
        this.editSummaryFlag = !this.editSummaryFlag
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

<style>
p {
  white-space: pre-wrap;
}
</style>
