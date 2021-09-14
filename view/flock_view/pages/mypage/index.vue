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
    <h1 class="my-5">
      {{ currentUser.name }}
    </h1>
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
  </div>
</template>

<script>
import axios from 'axios'
import firebase from '~/plugins/firebase'
import UserEdit from '../../components/UserEdit.vue'

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
      tab: null,
      userEditFlag: false,
      items: [
        '投稿', 'いいね', 'フォロー', 'フォロワー', '予定', '参加'
      ],
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
