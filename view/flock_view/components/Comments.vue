<template>
  <div>
    <v-card class="pa-15" flat>
      <v-textarea
        v-show="this.$store.state.user.loggedIn===true"
        v-model="body"
        height="100"
        label="コメント"
        outlined
      />
      <div style="text-align:right">
        <v-btn
          v-show="this.$store.state.user.loggedIn && this.body.length === 0"
          rounded
          depressed
          outlined
          disabled
          color="blue lighten-1"
          :ripple="false"
          @click="createComment()"
        >
          コメント
        </v-btn>
        <v-btn
          v-show="this.$store.state.user.loggedIn && this.body.length !== 0"
          rounded
          depressed
          color="blue lighten-1"
          dark
          :ripple="false"
          @click="createComment()"
        >
          コメント
        </v-btn>
      </div>
      <br>
      <br>
      <div v-show="comments.length === 0">
        <v-card flat class="my-5" :ripple="false">
          <v-card-text>コメントがありません</v-card-text>
        </v-card>
      </div>
      <div v-show="comments.length > 0">
        <div v-for="comment in comments" :key="comment.id">
          <v-divider />
          <v-card flat class="my-5" :ripple="false">
            <p v-show="currentUserId === comment.user.id">{{ comment.user.name }}</p>
            <p v-show="currentUserId !== comment.user.id"><nuxt-link :to="{ name: 'users-id', params: { id: comment.user.id } }">{{ comment.user.name }}</nuxt-link></p>
            <v-card-text><p style="font-size:20px">{{ comment.comment.body }}</p></v-card-text>
            <div style="text-align:right">
              <v-card-text>{{ dateFormat(comment.comment.created_at) }}</v-card-text>
            </div>
          </v-card>
        </div>
      </div>
    </v-card>
  </div>
</template>

<script>
import moment from 'moment'
import axios from 'axios'
  export default {
    props: {
      comments: Array,
      postId: Number
    },
    data () {
      return {
        body: '',
        currentUserId: this.$store.state.user.userId
      }
    },
    methods: {
      dateFormat: function(date){
        return moment(date).format('YYYY年MM月DD日')
      },
      createComment: function(){
        const createCommentUrl = this.$apiBaseUrl + '/comments'
        var params = new URLSearchParams();
        params.append('body', this.body);
        params.append('post_id', this.postId);
        params.append('user_id', this.$store.state.user.userId);
        axios.post(createCommentUrl, params)
          .then(() => {
            this.reload()
            this.body = ''
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
