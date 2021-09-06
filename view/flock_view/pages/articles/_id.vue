<template>
  <div>
      <v-row>
        <v-layout align-center justify-center>
          <h1 class="my-15">{{ post.title }}</h1>
        </v-layout>
        <v-sheet color="grey lighten-4" rouded="lg" class="ma-3 pa-6" width="1000px" max-width="1000px">
          <h3>要約</h3>
          <br>
          <p>{{ summary.content}}</p>
        </v-sheet>
      </v-row>

      <!-- -->
      <v-row>
        <v-col cols="9">
          <v-sheet class="pa-6" rounded="lg">
            <!-- 編集画面 -->
            <div v-show="editFlag===true && summaryFlag===false">
              <Form
                :post="post"
                @onEditFlag="onEditFlag"
                @offEditFlag="offEditFlag"
                @onSummaryFlag="onSummaryFlag"
                @offSummaryFlag="offSummaryFlag"
                />
            </div>
            <!-- 要約画面 -->
            <div v-show="editFlag===false && summaryFlag===true">
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
            <!-- 記事画面 -->
            <div v-show="editFlag===false && summaryFlag===false">
              <v-col>
                <Article :post="post" :summary="summary" />
              </v-col>
            </div>
          </v-sheet>
        </v-col>

        <v-col cols="3">
          <UserInfo :user="user" />
          <Tags />
          <v-sheet class="my-3 pa-3" color="blue-grey lighten-4" rounded="lg">
            <div class="my-2 mx-3"><v-icon color="pink" class="pr-2">mdi-heart</v-icon>{{ like.likes_count }}</div>
            <div v-show="this.$store.state.user.userId === this.user.id">
              <v-btn
                rounded
                depressed
                outlined
                dark
                color="blue"
                class="my-5"
                @click="onEditFlag()"
                >編集
              </v-btn>
            </div>
            <div v-show="this.$store.state.user.userId !== this.user.id &&this.$store.state.user.loggedIn">
              <v-btn
                v-show="like.is_like===0"
                dark
                rounded
                depressed
                color="pink"
                class="my-5"
                @click="createLike()"
                >いいね
              </v-btn>
              <v-btn
                v-show="like.is_like===1"
                dark
                rounded
                outlined
                depressed
                color="pink"
                class="my-5"
                @click="destroyLike()"
                >いいねをはずす
              </v-btn>
            </div>
          </v-sheet>
        </v-col>
      </v-row>
      <v-row>
        <v-col cols="12">
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
          <v-btn
            rounded
            depressed
            dark
            color="blue lighten-1"
            to='/friends'
            >一緒に遊ぶ友達を探す
          </v-btn>
        </v-col>
      </v-row>
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
import Tags from '../../components/Tags.vue'
export default {
  components: {
    Menu,
    Article,
    Form,
    Comments,
    Summary,
    UserInfo,
    Tags
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
          this.like = res.data
      })
    },
    createLike: function(){
      const createLikeUrl = this.$apiBaseUrl + '/likes'
      var params = new URLSearchParams();
      params.append('user_id', this.$store.state.user.userId);
      params.append('post_id', this.post.id);
      axios.post(createLikeUrl, params)
        .then((res) => {
          this.like = res.data
      })
    },
    destroyLike: function(){
      const destroyLikeUrl = this.$apiBaseUrl + '/likes?user_id=' + this.$store.state.user.userId + '&post_id=' + this.post.id
      axios.delete(destroyLikeUrl)
        .then((res) => {
          this.like = res.data
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
