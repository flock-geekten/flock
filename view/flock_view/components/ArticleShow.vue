<template>
  <div>
      <v-row>
        <v-layout align-center justify-center>
          <div class="post-title">{{ post.title }}</div>
        </v-layout>
			</v-row>
      <v-row>
        <v-layout align-center justify-center>
          <div class="flock">{{ post.flock }} flock</div>
        </v-layout>
			</v-row>
			<v-row>
        <v-card flat color="grey lighten-4" rouded="lg" class="ma-3 pa-6" width="1000px" max-width="1000px">
          <h2>要約</h2>
          <br>
          <p style="font-size:20px; line-height:36px">{{ summary.content}}</p>
        </v-card>
      </v-row>

      <v-row>
        <v-col cols="9">
          <v-card flat class="pa-6" rounded="lg">
            <!-- 記事画面 -->
            <div v-show="editFlag===false && summaryFlag===false">
              <v-col>
                <Article :post="post" :body="post.body" />
              </v-col>
            </div>
          </v-card>
        </v-col>

        <v-col cols="3">
          <UserInfo :user="user" />
          <Tags :tags="tags"/>
          <v-card flat class="my-3 pa-3" color="blue-grey lighten-4" rounded="lg">
            <div class="my-2 mx-3"><v-icon color="pink" class="pr-2">mdi-heart</v-icon>{{ like.likes_count }}</div>
            <div v-show="this.$store.state.user.userId !== this.user.id &&this.$store.state.user.loggedIn">
              <v-btn
                v-show="like.is_like===0"
                dark
                rounded
                depressed
                color="pink"
                class="my-5"
                :ripple="false"
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
                :ripple="false"
                @click="destroyLike()"
                >いいねをはずす
              </v-btn>
            </div>
          </v-card>
          <v-btn
            v-show="this.$store.state.user.loggedIn === true"
            rounded
            depressed
            dark
						block
            color="blue lighten-1"
            :ripple="false"
						@click="flock()"
            >flock
          </v-btn>
          <div v-show="this.$store.state.user.userId === this.user.id">
            <v-btn
              rounded
              depressed
              outlined
              dark
							block
              color="blue"
              class="my-5"
              :ripple="false"
              :to="{
                name: 'articles-edit-id',
                params: {
                  id: this.$route.params.id
                }
              }"
              >編集
            </v-btn>
          </div>
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
          :ripple="false"
          >←TOP
        </v-btn>
          <v-btn
            v-show="this.$store.state.user.loggedIn === true"
            rounded
            depressed
            dark
            color="blue lighten-1"
            to='/friends'
            :ripple="false"
            >一緒に遊ぶ友達を探す
          </v-btn>
        </v-col>
      </v-row>
  </div>
</template>

<script>
import moment from 'moment'
import axios from 'axios'
import Menu from './Menu.vue'
import Article from './Article.vue'
import Summary from './Summary.vue'
import Comments from './Comments.vue'
import Form from './Form.vue'
import UserInfo from './UserInfo.vue'
import Tags from './Tags.vue'
export default {
  components: {
    Menu,
    Article,
    Form,
    Comments,
    Summary,
    UserInfo,
    Tags,
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
      tags:'',
			flag: false
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
        this.tags = response.data.tags
				this.flag = true
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
		flock: function(){
			const flockUrl = this.$apiBaseUrl + '/api/v1/flock' 
			var params = {
				post_id: this.post.id 
			}
			localStorage.setItem('title', this.post.title)
			localStorage.setItem('link', this.$route.path)
			axios.post(flockUrl, params).then(
				this.$router.push('/plans/new')
			)
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

<style>
.post-title{
	font-weight: bolder;
	font-size: 40px;
  margin-top: 50px;	
  margin-bottom: 50px;	
}
.flock{
	font-weight: bold;
	font-size: 18px;
	margin-bottom: 20px; 
}
</style>