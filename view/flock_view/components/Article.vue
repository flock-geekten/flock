<template>
  <div>
    <h1>{{ post.title }}</h1>
    <br>
    <v-divider />
    <br>
    <v-sheet color="#EEEEEE" class="pa-5">
      <p>{{ summary.content }}</p>
    </v-sheet>
    <br>
    <p>{{ post.body }}</p>
  </div>
</template>

<script>
import moment from 'moment'
  export default {
    props: {
      post: Object,
      summary: Object
    },
    data () {
      return {
        createdAt: moment(this.post.created_at).format('YYYY年MM月DD日'),
        updatedAt: moment(this.post.updated_at).format('YYYY年MM月DD日'),
        summary: '',
        editSummaryFlag: false
      }
    },
    methods: {
      changeEditSummaryFlag: function(flag){
        this.editSummaryFlag = flag
      },
    }
  }
</script>

<style>
p {
  white-space: pre-wrap;
}
</style>
