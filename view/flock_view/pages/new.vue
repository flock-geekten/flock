<template>
  <div>
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
        @click="createPost"
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
        body: '',
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
      createPost: function(){
        const createPostUrl = 'http://localhost:3000' + '/posts'
        axios.defaults.headers.common['Content-Type'] = 'application/json';
        var params = new URLSearchParams();
        params.append('title', this.title);
        params.append('body', this.body);
        axios.post(createPostUrl, params).then(
          this.$router.push('/')
        )
      }
    }
  }
</script>
