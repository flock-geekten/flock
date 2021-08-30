<template>
  <div>
    <UserInfo :user="user" />
    <br>
    <v-sheet class="pa-15">
      <div v-if="editFlag">
        <Form
          :post="post"
          @onEditFlag="onEditFlag"
          @offEditFlag="offEditFlag"
          @onSummaryFlag="onSummaryFlag"
          @offSummaryFlag="offSummaryFlag"
          />
      </div>
      <div v-else-if="summaryFlag">
        <Summary
          :mode="2"
          :id="post.id"
          :title="post.title"
          :body="post.body"
          :summary="summary.content"
          @onEditFlag="onEditFlag"
          @offEditFlag="offEditFlag"
          @onSummaryFlag="onSummaryFlag"
          @offSummaryFlag="offSummaryFlag"
          />
      </div>
      <div v-else>
        <v-row>
          <v-col>
            <Article :post="post" :summary="summary" />
          </v-col>
        </v-row>
        <v-row>
          <v-col>
            <div v-if="this.$store.state.user.userId === this.user.id">
              <v-btn
                rounded
                depressed
                outlined
                dark
                color="blue"
                @click="onEditFlag()"
                >編集
              </v-btn>
            </div>
            <div v-else-if="this.$store.state.user.userId !== this.user.id &&this.$store.state.user.loggedIn">
              <v-btn
                v-if="like===0"
                rounded
                depressed
                dark
                outlined
                color="blue"
                @click="createLike()"
                >いいね
              </v-btn>
              <v-btn
                v-if="like===1"
                rounded
                depressed
                dark
                color="blue"
                @click="destroyLike()"
                >いいねをはずす
              </v-btn>
            </div>
          </v-col>
        </v-row>
      </div>

    </v-sheet>
    <br>
    <Comments 
      :comments="comments" 
      :postId="post.id"
      @reload="reload"
    />
    <br>
    <v-btn
      rounded
      depressed
      dark
      color="blue lighten-1"
      to='/'
      >←TOP
    </v-btn>
  </div>
</template>

<script>
import moment from 'moment'
import axios from 'axios'
import Menu from '../../components/Menu.vue'
import Article from '../../components/Article.vue'
import Summary from '../../components/Summary.vue'
import Comments from '../../components/Comments.vue'
import Form from '../../components/Form.vue'
import UserInfo from '../../components/UserInfo.vue'
export default {
  components: {
    Menu,
    Article,
    Form,
    Comments,
    Summary,
    UserInfo
  },
  data () {
    return {
      post: {},
      user: {},
      summary: {},
      comments: [],
      editFlag: false,
      summaryFlag: false,
      like: '',
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
        this.user = response.data.user
        this.summary = response.data.summary
        this.comments = response.data.comments
        this.isLike()
    })
  },
  methods: {
    reload: function(){
      const postUrl = '/api/v1/posts/' + this.$route.params.id
      this.$axios.get(postUrl, {
        headers: { 
          "Content-Type": "application/json", 
        }
      })
        .then(response => {
          this.post = response.data.post
          this.user = response.data.user
          this.summary = response.data.summary
          this.comments = response.data.comments
      })
    },
    isLike: function(){
      const isLikeUrl = this.$apiBaseUrl + '/is_like'
      var params = new URLSearchParams();
      params.append('user_id', this.$store.state.user.userId);
      params.append('post_id', this.post.id);
      axios.post(isLikeUrl, params)
        .then((res) => {
          this.like = res.data.is_like
      })
    },
    createLike: function(){
      const createLikeUrl = this.$apiBaseUrl + '/likes'
      var params = new URLSearchParams();
      params.append('user_id', this.$store.state.user.userId);
      params.append('post_id', this.post.id);
      axios.post(createLikeUrl, params)
        .then((res) => {
          this.like = res.data.is_like
      })
    },
    destroyLike: function(){
      const destroyLikeUrl = this.$apiBaseUrl + '/likes?user_id=' + this.$store.state.user.userId + '&post_id=' + this.post.id
      axios.delete(destroyLikeUrl)
        .then((res) => {
          this.like = res.data.is_like
      })
    },
    onEditFlag: function(){
      this.editFlag = true
    },
    offEditFlag: function(){
      const postUrl = '/posts/' + this.$route.params.id
      this.$axios.get(postUrl, {
        headers: { 
          "Content-Type": "application/json", 
        }
      })
        .then(response => {
          this.post = response.data
          // 要約文の取得
          const summaryUrl = '/posts/' + this.post.id + '/summaries'
          this.$axios.get(summaryUrl, {
            headers: { 
              "Content-Type": "application/json", 
            }
          })
          .then(response => {
            this.summary = response.data[0]
          })
      })
      this.editFlag = false
    },
    onSummaryFlag: function(){
      this.summaryFlag = true
    },
    offSummaryFlag: function(){
      this.summaryFlag = false
    },
  }
}
</script>
