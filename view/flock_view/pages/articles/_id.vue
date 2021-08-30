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
            <v-btn
              v-if="this.$store.state.user.userId === this.user.id"
              rounded
              depressed
              outlined
              dark
              color="blue"
              @click="onEditFlag()"
              >編集
            </v-btn>
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
      comments: '',
      editFlag: false,
      summaryFlag: false,
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
