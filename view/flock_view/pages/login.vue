<template>
  <div>
  <v-card max-width="500" class="mt-10 mx-auto">
    <v-snackbar
      v-model="snackbar"
      color="error"
      top
      right
    >
      {{ message }}
    </v-snackbar>
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
      <div class="w-100 px-4">
        <v-btn
          x-large
          color="blue"
          block
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
