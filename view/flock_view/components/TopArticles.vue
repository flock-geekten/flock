<template>
  <div>
    <v-row align="center" class="justify-center">
      <v-col cols="12" v-for="post in posts" :key="post.id">
        <ArticleCard :post="post" />
      </v-col>
    </v-row>
  </div>
</template>

<script>
import ArticleCard from './ArticleCard.vue'
export default {
  components:{
    ArticleCard
  },
  props: {
    posts: Object
  },
  filters: {
    omittedText200(text) {
     // 200文字目以降は"…"
     return text.length > 200 ? text.slice(0, 200) + "…" : text;
    },
    omittedText5(text) {
     // 20文字目以降は"…"
     return text.length > 5 ? text.slice(0, 5) + "…" : text;
    },
    omittedText80(text) {
     // 80文字目以降は"…"
     return text.length > 80 ? text.slice(0, 80) + "…" : text;
    },
    omittedText35(text) {
     // 80文字目以降は"…"
     return text.length > 35 ? text.slice(0, 35) + "…" : text;
    },
  },
}
</script>
