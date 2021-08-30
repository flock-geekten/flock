<template>
  <div>
    <v-sheet class="pa-3" color="green lighten-4" rounded="lg">
      <b><nuxt-link :to="{ name: 'users-id', params: { id: user.id } }">{{ user.name }}</nuxt-link> さんの投稿</b>
    </v-sheet>
  </div>
</template>

<script>
export default {
  props: {
    user: Object
  }
}
</script>
