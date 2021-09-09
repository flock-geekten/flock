<template>
  <div>
    <h1 class="py-5">{{ tag.name }}に関する記事</h1>
    <v-row align="center" class="justify-center">
      <v-col cols="12" v-for="post in posts" :key="post.id">
        <v-card 
          color="white" 
          flat
          height="350"
          max-height="800"
          :ripple="false"
          :to="{
               name: 'articles-id',
               params: {
               id: post.post.id
               }
               }"
          class="pa-5"
          >
          <v-row>
            <v-col cols="3">
              <v-img
                max-height="300"
                max-width="300"
                src="https://cdn.vuetifyjs.com/images/cards/cooking.png"
                ></v-img>
            </v-col>
            <v-col cols="9">
              <v-card-title>{{ post.post.title | omittedText20 }}</v-card-title>
              <v-card-text>{{ post.summary.content | omittedText200 }}</v-card-text>
            </v-col>
          </v-row>
          <v-row>
            <v-col cols="12">
              <v-chip>{{ post.tags[0].name | omittedText20 }}</v-chip> <v-chip>{{ post.tags[1].name | omittedText20 }}</v-chip> <v-chip>{{ post.tags[2].name | omittedText20 }}</v-chip><v-spacer /><v-card-text><v-icon class="mr-1" color="pink">mdi-heart-outline</v-icon>{{ post.likes_count }}<v-icon class="ml-3 mr-1" color="orange">mdi-comment-outline</v-icon>{{ post.comments_count }}</v-card-text>
            </v-col>
          </v-row>
        </v-card>
      </v-col>
    </v-row>
  </div>
</template>

<script>
import axios from 'axios'
export default {
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
