<template>
  <div>
    <h1 class="my-5">
      {{ user.name }}
    </h1>
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
    <!-- 投稿情報 -->
      <h3>投稿情報</h3>
      <v-list
          class="overflow-y-auto mx-auto"
          color="grey lighten-3"
          width="100%"
          height="400"
          max-height="1500"
          max-width="8000">
        <v-list-item v-show="posts.length === 0">
          <h3>投稿がまだありません</h3>
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
      <h3>いいね</h3>
      <v-list
          class="overflow-y-auto mx-auto"
          color="grey lighten-3"
          width="100%"
          height="400"
          max-height="1500"
          max-width="8000">
        <v-list-item v-show="likes.length === 0">
          <h3>いいねした記事がまだありません</h3>
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
      <h3>フォロー</h3>
      <v-list
          class="overflow-y-auto mx-auto"
          color="grey lighten-3"
          width="100%"
          height="400"
          max-height="1500"
          max-width="8000">
        <v-list-item v-show="followings.length === 0">
          <h3>フォローしている人はいません</h3>
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
      <h3>フォロワー</h3>
      <v-list
          class="overflow-y-auto mx-auto"
          color="grey lighten-3"
          width="100%"
          height="400"
          max-height="1500"
          max-width="8000">
        <v-list-item v-show="followers.length === 0">
          <h3>フォローされている人はいません</h3>
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
      <h3>予定情報</h3>
      <v-list
          class="overflow-y-auto mx-auto"
          color="grey lighten-3"
          width="100%"
          height="400"
          max-height="1500"
          max-width="8000">
        <v-list-item v-show="plans.length === 0">
          <h3>まだ予定はありません</h3>
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
      <h3>参加情報</h3>
      <v-list
          class="overflow-y-auto mx-auto"
          color="grey lighten-3"
          width="100%"
          height="400"
          max-height="1500"
          max-width="8000">
        <v-list-item v-show="participations.length === 0">
          <h3>参加予定はありません</h3>
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
