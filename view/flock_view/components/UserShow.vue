<template>
  <div>
    <div class="post-title">
      {{ user.name }}
    </div>
    <p>{{ user.profile }}</p>
    <div v-show="this.user.id !== this.$store.state.user.userId && this.$store.state.user.loggedIn">
      <v-btn
        v-show="follow===0"
        rounded
        depressed
        dark
        outlined
        color="blue"
        :ripple="false"
        @click="createFollow()"
        >フォロー
      </v-btn>
      <v-btn
        v-show="follow===1"
        rounded
        depressed
        dark
        color="blue"
        :ripple="false"
        @click="destroyFollow()"
        >フォローをはずす
      </v-btn>
    </div>
    <br>
    <v-card flat>
      <v-toolbar
        color="white"
        flat
        >
        <template v-slot:extension>
          <v-tabs
            v-model="tab"
            align-with-title
            >
            <v-tabs-slider color="blue"></v-tabs-slider>

            <v-tab
              v-for="item in items"
              :key="item"
              >
              {{ item }}
            </v-tab>
          </v-tabs>
        </template>
      </v-toolbar>

      <v-tabs-items v-model="tab">

        <!-- 投稿情報 -->
        <v-tab-item>
          <v-card flat>
            <v-card-text>
              <div v-show="posts.length === 0"><v-card-text>投稿がまだありません</v-card-text></div>
              <div v-show="postslenth !== 0" v-for="post in posts" :key="post.id">
                <v-card 
                   flat 
                   color="grey lighten-3" 
                   class="pa-5"
                   :ripple="false"
                   :to="{
                        name: 'articles-id',
                        params: {
                        id: post.post.id
                        }
                        }"
                   >
                  <v-card-title>{{ post.post.title }}<v-spacer /><v-icon class="mr-1" color="pink">mdi-heart-outline</v-icon>{{ post.likes_count }}<v-icon class="ml-3 mr-1" color="orange">mdi-comment-outline</v-icon>{{ post.comments_count }}</v-card-title>
                   <v-card-text>{{ post.summary.content }}</v-card-text>
                </v-card>
                  <br>
              </div>
            </v-card-text>
          </v-card>
        </v-tab-item>

        <!-- いいね情報 -->
        <v-tab-item>
          <v-card flat>
            <v-card-text>
              <div v-show="likes.length === 0"><v-card-text>まだいいねした投稿がありません</v-card-text></div>
              <div v-show="likes.length !== 0" v-for="like in likes" :key="like.id">
                <v-card 
                   flat 
                   color="grey lighten-3" 
                   class="pa-5"
                   :ripple="false"
                   :to="{
                        name: 'articles-id',
                        params: {
                        id: like.post.id
                        }
                        }"
                   >
                  <v-card-title>{{ like.post.title }}<v-spacer /><v-icon class="mr-1" color="pink">mdi-heart-outline</v-icon>{{ like.likes_count }}<v-icon class="ml-3 mr-1" color="orange">mdi-comment-outline</v-icon>{{ like.comments_count }}</v-card-title>
                   <v-card-text>{{ like.summary.content }}</v-card-text>
                </v-card>
                  <br>
              </div>
            </v-card-text>
          </v-card>
        </v-tab-item>

        <!-- フォロー情報 -->
        <v-tab-item>
          <v-card flat class="px-10 pt-5">
            <div v-show="followings.length === 0"><v-card-text>フォローしているユーザーはいません</v-card-text></div>
            <div v-show="followings.length !== 0" v-for="following in followings" :key="following.id">
              <li><nuxt-link :to="{ name: 'users-id', params: { id: following.id } }">{{ following.name }}</nuxt-link></li>
            </div>
          </v-card>
        </v-tab-item>

        <!-- フォロワー情報 -->
        <v-tab-item>
          <v-card flat class="px-10 pt-5">
            <div v-show="followers.length === 0"><v-card-text>フォローされているユーザーはいません</v-card-text></div>
            <div v-show="followers.length !== 0" v-for="follower in followers" :key="follower.id">
              <li><nuxt-link :to="{ name: 'users-id', params: { id: follower.id } }">{{ follower.name }}</nuxt-link></li>
            </div>
          </v-card>
        </v-tab-item>

        <!-- 予定情報 -->
        <v-tab-item>
          <v-card flat>
            <v-card-text>
              <div v-show="plans.length === 0"><v-card-text>まだ予定はありません</v-card-text></div>
              <div v-show="plans.length !== 0" v-for="plan in plans" :key="plan.id">
                <v-card 
                   flat 
                   color="grey lighten-3" 
                   class="pa-5"
                   :ripple="false"
                   :to="{
                        name: 'plans-id',
                        params: {
                        id: plan.id
                        }
                        }"
                   >
                  <v-card-title>{{ plan.title }}</v-card-title>
                   <v-card-text>{{ plan.body }}</v-card-text>
                </v-card>
                  <br>
              </div>
            </v-card-text>
          </v-card>
        </v-tab-item>

        <!-- 参加情報 -->
        <v-tab-item>
          <v-card flat>
            <v-card-text>
              <div v-show="participations.length === 0"><v-card-text>まだ参加予定の情報はありません</v-card-text></div>
              <div v-show="participations.length !== 0" v-for="participation in participations" :key="participation.id">
                <v-card
                   flat
                   color="grey lighten-3"
                   class="pa-5"
                   :ripple="false"
                   :to="{
                        name: 'plans-id',
                        params: {
                        id: participation.id
                        }
                        }"
                   >
                  <v-card-title>{{ participation.title }}</v-card-title>
                   <v-card-text>{{ participation.body }}</v-card-text>
                </v-card>
                  <br>
              </div>
            </v-card-text>
          </v-card>
        </v-tab-item>

      </v-tabs-items>
    </v-card>
  </div>
</template>

<script>
import axios from 'axios'
export default {
  data () {
    return {
      user: '',
      posts: '',
      likes: '',
      follow: '',
      followings: '',
      followers: '',
      plans: '',
      participations: '',
      tab: null,
      items: [
        '投稿', 'いいね', 'フォロー', 'フォロワー', '予定', '参加'
      ],
    }
  },
  mounted() {
    const userUrl = '/users/' + this.$route.params.id
    this.$axios.get(userUrl)
      .then((res) => {
        this.user = res.data.user
        this.posts = res.data.posts
        this.likes = res.data.likes
        this.followings = res.data.followings
        this.followers = res.data.followers
        this.plans = res.data.plans
        this.participations = res.data.participations
        this.participations = res.data.participations
        this.isFollow()
      })
  },
  methods: {
    isFollow: function(){
      const isFollowUrl = this.$apiBaseUrl + '/is_follow'
      var params = new URLSearchParams();
      params.append('user_id', this.$store.state.user.userId);
      params.append('target_user_id', this.user.id);
      axios.post(isFollowUrl, params)
        .then((res) => {
          this.follow = res.data.is_follow
        })
    },
    createFollow: function(){
      const followUrl = this.$apiBaseUrl + '/follow'
      var params = new URLSearchParams();
      params.append('user_id', this.$store.state.user.userId);
      params.append('following_id', this.user.id);
      axios.post(followUrl, params)
        .then((res) => {
          this.follow = res.data.is_follow
        })
    },
    destroyFollow: function(){
      const unFollowUrl = this.$apiBaseUrl + '/unfollow?user_id=' + this.$store.state.user.userId + '&following_id=' + this.user.id
      axios.delete(unFollowUrl)
        .then((res) => {
          this.follow = res.data.is_follow
        })
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
</style>