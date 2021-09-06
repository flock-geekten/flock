<template>
  <div> 
  <div style="text-align:center">
    <h1 class="py-3">新規登録</h1>
  </div>
  <v-card v-if="detailFlag === true" flat max-width="500" class="p-4 mt-10 mx-auto">
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
              v-model="name"
              label="名前"
              required
            />
          </v-col>
          <v-col cols="12">
            <v-text-field
              v-model="age"
              type="number"
              label="年齢"
              required
            />
          </v-col>
          <v-col cols="12">
            <v-select
              v-model="sex"
              :items="sexList"
              item-text="text"
              item-value="value"
              label="性別"
              required
              ></v-select>
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
          outlined
          dark
          color="blue"
          class="mx-auto mb-5"
          @click="detailFlag = false"
        >
          戻る
        </v-btn>
        <v-btn
          rounded
          depressed
          outlined
          dark
          color="blue"
          class="mx-auto mb-5"
          @click="signup()"
        >
          新規登録
        </v-btn>
      </div>
    </v-card-actions>
    <div class="mx-auto text-center pb-5">
      <nuxt-link to="/login">
        ログインはこちら
      </nuxt-link>
    </div>
  </v-card>

  <v-card v-else flat max-width="500" class="p-4 mt-10 mx-auto">
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
          <v-col cols="12">
            <v-text-field
              v-model="passwordConfirm"
              :append-icon="isPasswordShow ? 'mdi-eye' : 'mdi-eye-off'"
              :type="isPasswordShow ? 'text' : 'password'"
              label="パスワード確認"
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
          v-if="password === passwordConfirm"
          rounded
          depressed
          outlined
          dark
          color="blue"
          class="mx-auto mb-5"
          @click="detailFlag = true"
        >
          次へ
        </v-btn>
        <v-btn
          v-else
          disabled
          rounded
          depressed
          outlined
          dark
          color="blue"
          class="mx-auto mb-5"
          @click="detailFlag = true"
        >
          次へ
        </v-btn>
      </div>
    </v-card-actions>
    <div class="mx-auto text-center pb-5">
      <nuxt-link to="/login">
        ログインはこちら
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
      name: '',
      email: '',
      password: '',
      passwordConfirm: '',
      isPasswordShow: false,
      message: '',
      snackbar: false,
      age: '',
      sex: '',
      sexList: [
        { text: '男', value: 1 },
        { text: '女', value: 2 }
      ],
      detailFlag: false
    }
  },
  methods: {
    signup(){
      firebase.auth()
        .createUserWithEmailAndPassword(this.email, this.password)
        .then((res) => {
          const url = this.$apiBaseUrl + '/users'
          var params = new URLSearchParams();
          params.append('name', this.name);
          params.append('email', res.user.email);
          params.append('uid', res.user.uid);
          params.append('age', Number(this.age));
          params.append('sex', this.sex);
          this.$store.commit('user/setUid', res.user.uid)
          this.$store.commit('user/login')
          axios.post(url, params)
            .then((res) => {
              this.$store.commit('user/setUser', res.data)
              this.$router.push('/')
            })
            .catch((error) => {
              console.log(error)
            })
        })
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
