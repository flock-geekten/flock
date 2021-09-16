<template>
  <div>
    <h1 class="py-5">友達レコメンド</h1>
    <h3>相性のいい友達</h3>
    <div v-show="users.length === 0" style="text-align:center">
      <v-progress-circular
        indeterminate
        color="blue lighten-1"
       />
    </div>
    <div v-show="users.length !== 0">
      <div v-for="user in users" :key="user.id" class="py-1">
        <v-card class="my-2 pa-3" flat>
          <v-card-title>
          <nuxt-link :to="{ name: 'users-id', params: { id: user.user_id } }">{{ user.name }}</nuxt-link>
          </v-card-title>
          <v-card-text>
            <p>{{ user.profile }}</p>
            <v-rating
              v-show="user.score > 0.6"
              v-model="scoreList[0]"
              empty-icon="mdi-heart-outline"
              full-icon="mdi-heart"
              half-icon="mdi-heart-half-full"
              background-color="red lighten-3"
              color="red"
              readonly
              ></v-rating>
            <v-rating
              v-show="user.score > 0.4 && user.score <= 0.6"
              v-model="scoreList[1]"
              empty-icon="mdi-heart-outline"
              full-icon="mdi-heart"
              half-icon="mdi-heart-half-full"
              background-color="red lighten-3"
              color="red"
              readonly
              ></v-rating>
            <v-rating
              v-show="user.score > 0.1 && user.score <= 0.4"
              v-model="scoreList[2]"
              empty-icon="mdi-heart-outline"
              full-icon="mdi-heart"
              half-icon="mdi-heart-half-full"
              background-color="red lighten-3"
              color="red"
              readonly
              ></v-rating>
            <v-rating
              v-show="user.score <= 0.1"
              v-model="scoreList[3]"
              empty-icon="mdi-heart-outline"
              full-icon="mdi-heart"
              half-icon="mdi-heart-half-full"
              background-color="red lighten-3"
              color="red"
              readonly
              ></v-rating>
          </v-card-text>
        </v-card>
      </div>
      <v-btn to="/plans/new" color="blue lighten-1" dark depressed rounded :ripple="false">計画を立てる</v-btn>
    </div>
  </div>
</template>

<script>
import axios from 'axios'
export default {
  data () {
    return {
      users: '',
      scoreList: [5, 4, 3, 2]
    }
  },
  mounted() {
    this.$axios.post('/api/v1/friends?user_id=' + this.$store.state.user.userId, {
      headers: { 
        "Content-Type": "application/json", 
      }
    })
      .then(response => {
        this.users = response.data.slice(0, 10)
      })
  }
}
</script>
