<template>
  <div>
    <div class="post-title">{{ tag.name }}に関する記事</div>
    <v-row align="center" class="justify-center">
      <v-col cols="12" v-for="post in posts" :key="post.id">
        <ArticleCard :post="post" v-show="$device.isDesktopOrTablet" />
        <ArticleCardMobile :post="post" v-show="$device.isMobile" />
      </v-col>
    </v-row>
  </div>
</template>

<script>
import axios from 'axios'
import ArticleCard from '../../components/ArticleCard.vue'
import ArticleCardMobile from '../../components/ArticleCardMobile.vue'
export default {
  components: {
    ArticleCard,
    ArticleCardMobile,
  },
  data () {
    return {
      tag: '',
      posts: '',
    }
  },
  mounted() {
    this.$axios.get('/api/v1/tags/' + this.$route.params.id + '/posts', {
      headers: { 
        "Content-Type": "application/json", 
      }
    })
      .then(response => {
        this.tag = response.data.tag
        this.posts = response.data.posts
      })
  }
}
</script>

<style>
.post-title{
	font-weight: bolder;
	font-size: 40px;
  margin-top: 50px;	
  margin-bottom: 50px;	
}
</style>