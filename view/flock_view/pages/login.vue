<template>
  <div>
  <v-card flat max-width="500" class="mt-10 mx-auto">
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
      <v-container>
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
      </v-container>
    </v-card-text>
    <v-card-actions>
      <v-spacer></v-spacer>
      <div class="w-100 px-4" style="text-align:center">
        <v-btn
          rounded
          depressed
          dark
          color="blue"
          class="mx-auto mb-5"
          @click="login()"
        >
          ログイン
        </v-btn>
      </div>
    </v-card-actions>
    <div class="mx-auto text-center pb-5">
      <nuxt-link to="/signup">
        新規登録はこちら
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
            console.log(response.data)
            this.$store.commit('user/setUser', response.data)
            console.log(this.$store.state.user.user)
          })
          this.$store.commit('user/login')
          this.$router.push('/')
        })
        .catch(() => {
          this.message = 'メールアドレスまたはパスワードが正しくありません'
          this.snackbar = true
        });
    },
  }
}
</script>

<style scoped>
.w-100 {
  width: 100%;
}
</style>
