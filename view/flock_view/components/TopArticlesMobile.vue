<template>
  <div>
    <v-row align="center" class="justify-center">
      <v-col cols="12" v-for="post in posts" :key="post.id">
        <ArticleCardMobile :post="post" />
      </v-col>
    </v-row>
  </div>
</template>

<script>
import ArticleCardMobile from './ArticleCardMobile.vue'
export default {
  components: {
    ArticleCardMobile
  },
  props: {
    posts: Object
  },
}
</script>
