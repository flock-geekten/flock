<template>
  <div>
  <v-card flat color="white" max-width="500" class="mt-10 mx-auto">
    <v-snackbar
      v-model="snackbar"
      color="error"
      top
      right
    >
      {{ message }}
    </v-snackbar>
    <v-card-title>ログイン</v-card-title>
    <v-card-text>
        <v-row>
          <v-col cols="12">
            <v-text-field
              v-model="email"
              label="メールアドレス"
              required
            />
          </v-col>
          <v-col cols="12">
            <v-text-field
              v-model="password"
              :append-icon="isPasswordShow ? 'mdi-eye' : 'mdi-eye-off'"
              :type="isPasswordShow ? 'text' : 'password'"
              label="パスワード"
              @click:append="isPasswordShow = !isPasswordShow"
            />
          </v-col>
        </v-row>
    </v-card-text>
    <v-card-actions>
      <v-spacer></v-spacer>
      <div class="w-100 px-4" style="text-align:center">
        <v-btn
          rounded
          depressed
          dark
          color="blue"
          class="mx-auto mb-1"
          @click="login()"
        >
          ログイン
        </v-btn>
      </div>
    </v-card-actions>
		<div style="text-align:center">
			<v-btn class="mb-5" @click="googleLogin()" width="180px" height="100%" color="white" depressed dark :ripple="false">
				<v-img class="text-center" width="180px" height="100%" src="https://firebasestorage.googleapis.com/v0/b/flock-geekten.appspot.com/o/btn_google_signin_light_normal_web%402x.png?alt=media&token=fe67956a-0718-44ff-b6c4-5a91dd4d0517"></v-img>
			</v-btn>
		</div>
    <div class="mx-auto text-center pb-5">
      <nuxt-link to="/signup">
        メールアドレスで新規登録はこちら
      </nuxt-link>
    </div>
  </v-card>
  </div>
</template>

<script>
import firebase from '~/plugins/firebase'
import axios from 'axios'

export default {
  data: () => {
    return {
      email: '',
      password: '',
      isPasswordShow: false,
      message: '',
      snackbar: false,
			result: '',
    }
  },
  methods: {
    login() {
      firebase.auth()
        .signInWithEmailAndPassword(this.email, this.password)
        .then((res) => {
          this.$store.commit('user/setUid', res.user.uid)
          const url = this.$apiBaseUrl + '/api/v1/current_user'
          var params = new URLSearchParams();
          params.append('uid', res.user.uid);
          axios.post(url, params).then((response) => {
            this.$store.commit('user/setUser', response.data.user)
            this.$store.commit('user/setUserId', response.data.user.id)
            this.$store.commit('user/setUserName', response.data.user.name)
          })
          this.$store.commit('user/login')
          this.$router.push('/')
        })
        .catch(() => {
          this.message = 'メールアドレスまたはパスワードが正しくありません'
          this.snackbar = true
        });
    },
		googleLogin() {
			var provider = new firebase.auth.GoogleAuthProvider()
			firebase.auth().signInWithPopup(provider).then((result) => {
				const url = this.$apiBaseUrl + '/api/v1/current_user'
				var params = new URLSearchParams();
				var firstFlag
				params.append('email', result.user.email);
				params.append('name', result.user.displayName);
				params.append('uid', result.user.uid);
				axios.post(url, params).then((response) => {
					this.$store.commit('user/setUser', response.data.user)
					this.$store.commit('user/setUid', response.data.user.uid)
					this.$store.commit('user/setUserId', response.data.user.id)
					this.$store.commit('user/setUserName', response.data.user.name)
					firstFlag = response.data.first_flag
					this.$store.commit('user/login')
					if (firstFlag == 1){
						this.$router.push('/hangouts/first')
					}else{
						this.$router.push('/')
					}
				})
			}).catch(function (error) {
				console.log(error)
			})
		},
  }
}
</script>

<style scoped>
.w-100 {
  width: 100%;
}
</style>
