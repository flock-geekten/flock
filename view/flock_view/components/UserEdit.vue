<template>
  <div>
    <div class="post-title">プロフィールを編集する</div>
      <v-row>
        <v-col cols="4">
          <v-text-field
						outlined
            v-model="name"
            label="名前"
          />
        </v-col>
        <v-col cols="4">
				<v-select
					outlined
					label="年齢"
          :items="ageList"
					v-model="age"
        ></v-select>	
        </v-col>
        <v-col cols="4">
          <v-select
						outlined
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
						outlined
            label="プロフィール"
          />
        </v-col>
        <v-btn
          rounded
          depressed
          color="blue lighten-1"
          class="ma-1"
          dark
          :ripple="false"
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
          :ripple="false"
          @click="edit()"
          >
          編集
        </v-btn>
      </v-row>
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
			ageList: [...Array(100).keys()].map(i => ++i)
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
.post-title{
	font-weight: bolder;
	font-size: 40px;
  margin-top: 50px;	
  margin-bottom: 50px;	
}
</style>
