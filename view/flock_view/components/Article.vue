<template>
  <div>
    <v-sheet>
      <h1>{{ post.title }}</h1>
      <br>
      <v-divider />
      <br>
      <p>{{ post.body }}</p>
    </v-sheet>
  </div>
</template>

<script>
import moment from 'moment'
  export default {
    props: {
      post: Object
    },
    data () {
      return {
        createdAt: moment(this.post.created_at).format('YYYY年MM月DD日'),
        updatedAt: moment(this.post.updated_at).format('YYYY年MM月DD日'),
      }
    }
  }
</script>

<style>
p {
  white-space: pre-wrap;
}
</style>
