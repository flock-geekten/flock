<template>
  <div>
    <div v-show="userEditFlag===true">
      <UserEdit 
        :name="currentUser.name"
        :email="currentUser.email"
        :age="currentUser.age"
        :sex="currentUser.sex"
        :profile="currentUser.profile"
        @getCurrentUser="getCurrentUser"
        @offUserEditFlag="offUserEditFlag"
      />
    </div>
    <div v-show="userEditFlag===false">
    <div class="post-title">
      {{ currentUser.name }}
    </div>
    <p>{{ currentUser.profile }}</p>
    <v-btn
      rounded
      depressed
      outlined
      dark
      color="blue"
      :ripple="false"
      @click="userEditFlag = true"
      >
      プロフィールを編集
    </v-btn>
      <br><br>
    <v-btn
      rounded
      depressed
      outlined
      dark
      color="blue"
      :ripple="false"
      to="/hangouts/choose"
      >
      あそびを選択する
    </v-btn>
    <br><br>

    <!-- 投稿情報 -->
      <h2>投稿情報</h2>
      <v-list
          class="overflow-y-auto mx-auto"
          color="grey lighten-3"
          width="100%"
          height="400"
          max-height="1500"
          max-width="8000">
        <v-list-item v-show="posts.length === 0">
          <h2>投稿がまだありません</h2>
        </v-list-item>
        <v-list-item
            v-show="posts.length !== 0"
            v-for="post in posts"
            :key="post.id">
                <v-card 
                   flat 
                   color="white" 
                   class="pa-5 my-3"
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
        </v-list-item>
    </v-list>

    <!-- いいね -->
    <br><br>
      <h2>いいね</h2>
      <v-list
          class="overflow-y-auto mx-auto"
          color="grey lighten-3"
          width="100%"
          height="400"
          max-height="1500"
          max-width="8000">
        <v-list-item v-show="likes.length === 0">
          <h2>いいねした記事がまだありません</h2>
        </v-list-item>
        <v-list-item
            v-show="likes.length !== 0"
            v-for="(like, index) in likes"
            :key="index">
                <v-card 
                   flat 
                   color="white" 
                   class="pa-5 my-3"
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
        </v-list-item>
    </v-list>

    <!-- フォロー情報 -->
    <br><br>
      <h2>フォロー</h2>
      <v-list
          class="overflow-y-auto mx-auto"
          color="grey lighten-3"
          width="100%"
          height="400"
          max-height="1500"
          max-width="8000">
        <v-list-item v-show="followings.length === 0">
          <h2>フォローしている人はいません</h2>
        </v-list-item>
        <v-list-item
            v-show="followings.length !== 0"
            v-for="(following, index) in followings"
            :key="index">
            <li><nuxt-link :to="{ name: 'users-id', params: { id: following.id } }">{{ follower.name }}</nuxt-link></li>
        </v-list-item>
    </v-list>

    <!-- フォロワー情報 -->
    <br><br>
      <h2>フォロワー</h2>
      <v-list
          class="overflow-y-auto mx-auto"
          color="grey lighten-3"
          width="100%"
          height="400"
          max-height="1500"
          max-width="8000">
        <v-list-item v-show="followers.length === 0">
          <h2>フォローされている人はいません</h2>
        </v-list-item>
        <v-list-item
            v-show="followers.length !== 0"
            v-for="(follower, index) in followers"
            :key="index">
            <li><nuxt-link :to="{ name: 'users-id', params: { id: follower.id } }">{{ follower.name }}</nuxt-link></li>
        </v-list-item>
    </v-list>

    <!-- 予定情報 -->
    <br><br>
      <h2>予定情報</h2>
      <v-list
          class="overflow-y-auto mx-auto"
          color="grey lighten-3"
          width="100%"
          height="400"
          max-height="1500"
          max-width="8000">
        <v-list-item v-show="plans.length === 0">
          <h2>まだ予定はありません</h2>
        </v-list-item>
        <v-list-item
            v-show="plans.length !== 0"
            v-for="(plan, index) in plans"
            :key="index">
                <v-card 
                   flat 
                   color="white" 
                   class="pa-5 my-3"
                   width="100%"
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
        </v-list-item>
    </v-list>

    <!-- 参加情報 -->
    <br><br>
      <h2>参加情報</h2>
      <v-list
          class="overflow-y-auto mx-auto"
          color="grey lighten-3"
          width="100%"
          height="400"
          max-height="1500"
          max-width="8000">
        <v-list-item v-show="participations.length === 0">
          <h2>参加予定はありません</h2>
        </v-list-item>
        <v-list-item
            v-show="participations.length !== 0"
            v-for="(participation, index) in participations"
            :key="index">
                <v-card 
                   flat 
                   color="white" 
                   class="pa-5 my-3"
                   width="100%"
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
        </v-list-item>
    </v-list>
    </div>
  </div>
</template>

<script>
import axios from 'axios'
import firebase from '~/plugins/firebase'
import UserEdit from './UserEdit.vue'

export default {
  components: {
    UserEdit
  },
  data: () => {
    return {
      message: '',
      currentUser: '',
      posts: '',
      likes: '',
      followings: '',
      followers: '',
      plans: '',
      participations: '',
      userEditFlag: false,
    }
  },

  mounted() {
    this.message = firebase.auth()
    if (this.$store.state.user.uid !== ''){
      this.getCurrentUser()
    }
  },
  methods: {
    getCurrentUser: function(){
      const currentUserUrl = this.$apiBaseUrl + '/api/v1/current_user'
      var params = new URLSearchParams();
      params.append('uid', this.$store.state.user.uid);
      axios.post(currentUserUrl, params)
        .then((res) => {
          this.currentUser = res.data.user
          this.posts = res.data.posts
          this.likes = res.data.likes
          this.followings = res.data.followings
          this.followers = res.data.followers
          this.plans = res.data.plans
          this.participations = res.data.participations
        })
    },
    offUserEditFlag: function(){
      this.userEditFlag = false
    }
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