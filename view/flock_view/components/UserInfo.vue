<template>
  <div>
    <v-card flat class="pa-3" color="green lighten-4" rounded="lg" width="100%" max-width="100%">
      <b><nuxt-link :to="{ name: 'users-id', params: { id: user.id } }">{{ user.name }}</nuxt-link> さんの投稿</b>
      <p v-show="user.age !== null" class="my-2">{{ user.age }}歳 {{ sexList[user.sex - 1] }}</p>
      <p v-show="user.profile !== null" class="my-2">{{ user.profile }}</p>
    </v-card>
  </div>
</template>

<script>
export default {
  props: {
    user: Object
  },
  data() {
    return {
      sexList: ['男性', '女性', 'その他']
    }
  }
}
</script>
