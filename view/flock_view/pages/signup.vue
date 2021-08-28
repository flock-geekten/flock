<template>
  <v-card max-width="500" class="p-4 mt-10 mx-auto">
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
          @click="signup()"
        >
          新規登録
        </v-btn>
      </div>
    </v-card-actions>
  </v-card>
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
    signup(){
      firebase.auth()
        .createUserWithEmailAndPassword(this.email, this.password)
        .then((res) => {
          const params = { token: res.user.za, registration: { email: res.user.email } }
          const url = '/api/v1/users/registrations'
          this.$axios.post(url, params)
            .then((res) => {
              console.log(res)
              this.$router.push("/")
            })
            .catch((error) => {
              console.log(error)
            })
        })
    },
    login() {
      firebase.auth()
        .createUserWithEmailAndPassword(this.email, this.password)
        .then(() => {
          this.$router.push('/')
        })
        .catch((error) => {
          this.setErrorMessage(error.code)
          this.snackbar = true
        });
    },
    setErrorMessage(errorCode) {
      switch (errorCode) {
        case 'auth/invalid-email':
          this.message = 'メールアドレスの形式に誤りがあります。'
          break
        case 'auth/email-already-in-use':
          this.message = '入力されたメールアドレスは既に使用されています。'
          break
        case 'auth/weak-password':
          this.message = 'パスワードは6文字以上で入力してください。'
          break
        default:
          this.message = '新規登録に失敗しました。'
          break
      }
    },
  }
}
</script>

<style scoped>
.w-100 {
  width: 100%;
}
</style>
