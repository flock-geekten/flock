<template>
  <div>
    <v-sheet class="pa-2" color="green lighten-4" rounded="lg">
      <b>{{ user.name }}さんの投稿</b>
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
