<template>
  <div>
    <v-sheet class="pa-15">
      <v-textarea
        v-model="body"
        height="100"
        label="コメント"
        outlined
      />
      <div style="text-align:right">
        <v-btn
          rounded
          depressed
          color="blue lighten-1"
          dark
          @click="createComment()"
        >
          コメント
        </v-btn>
      </div>
      <br>
      <br>
      <div v-for="comment in comments" :key="comment.id">
        <v-divider />
        <v-card flat class="my-5">
          <p><nuxt-link :to="{ name: 'users-id', params: { id: comment.user.id } }">{{ comment.user.name }}</nuxt-link></p>
          <v-card-text>{{ comment.comment.body }}</v-card-text>
        </v-card>
      </div>
    </v-sheet>
  </div>
</template>

<script>
  import axios from 'axios'
  export default {
    props: {
      comments: Object,
      postId: Number
    },
    data () {
      return {
        body: ''
      }
    },
    methods: {
      createComment: function(){
        const createCommentUrl = this.$apiBaseUrl + '/comments'
        var params = new URLSearchParams();
        params.append('body', this.body);
        params.append('post_id', this.postId);
        params.append('user_id', this.$store.state.user.userId);
        axios.post(createCommentUrl, params)
          .then(() => {
            this.reload()
          })
      },
      reload: function(){
        this.$emit('reload')
      }
    },
  }
</script>

<style>
p {
  white-space: pre-wrap;
}
</style>
