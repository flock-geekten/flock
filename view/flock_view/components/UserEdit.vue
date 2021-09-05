<template>
  <div>
    <h1>プロフィールを編集する</h1>
    <v-container>
      <v-row>
        <v-col cols="12">
          <v-text-field
            v-model="name"
            label="名前"
          />
        </v-col>
        <v-col cols="12">
          <v-text-field
            v-model="age"
            type="number"
            label="年齢"
          />
        </v-col>
        <v-col cols="12">
          <v-select
            v-model="sex"
            :items="sexList"
            item-text="text"
            item-value="value"
            label="性別"
            ></v-select>
        </v-col>
        <v-col cols="12">
          <v-textarea
            v-model="profile"
            label="プロフィール"
          />
        </v-col>
        <v-btn
          rounded
          depressed
          color="blue lighten-1"
          class="ma-1"
          dark
          @click="offUserEditFlag()"
          >
          戻る
        </v-btn>
        <v-btn
          rounded
          depressed
          color="blue lighten-1"
          class="ma-1"
          dark
          @click="edit()"
          >
          編集
        </v-btn>
      </v-row>
    </v-container>
  </div>
</template>

<script>
import axios from 'axios'

export default {
  props: {
    name: String,
    email: String,
    age: Number,
    sex: Number,
    profile: String
  },
  data: () => {
    return {
      sexList: [
        { text: '男', value: 1 },
        { text: '女', value: 2 }
      ],
    }
  },
  methods: {
    edit: function(){
      const url = this.$apiBaseUrl + '/users/' + this.$store.state.user.userId + '?name=' + this.name + '&email=' + this.email + '&age=' + this.age + '&sex=' + this.sex + '&profile=' + this.profile
      axios.put(url)
        .then((res) => {
          this.$store.commit('user/setUser', res.data)
          this.$emit('getCurrentUser')
          this.offUserEditFlag()
        })
        .catch((error) => {
          console.log(error)
        })
    },
    offUserEditFlag: function(){
      this.$emit('offUserEditFlag')
    }
  }
}
</script>

<style scoped>
.w-100 {
  width: 100%;
}
</style>
