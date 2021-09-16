<template>
  <div>
    <v-row align="center" class="justify-center">
      <v-col cols="12" v-for="post in posts" :key="post.id">
        <v-card 
          color="white" 
          flat
          rounded
          height="320"
          max-height="320"
          :to="{
               name: 'articles-id',
               params: {
               id: post.post.id
               }
               }"
          class="pa-8" 
          :ripple="false"
          >
          <v-row>
            <v-card-title><h2>{{ post.post.title | omittedText35 }}</h2></v-card-title>
          </v-row>
          <v-row>
            <v-col cols="3">
              <v-row>
                <v-img
                  class="my-3"
                  max-height="200"
                  max-width="200"
                  src="https://cdn.vuetifyjs.com/images/cards/cooking.png"
                  ></v-img>
              </v-row>
              <v-row>
<v-card-text><v-icon class="mr-1" color="pink">mdi-heart-outline</v-icon>{{ post.likes_count }}<v-icon class="ml-3 mr-1" color="orange">mdi-comment-outline</v-icon>{{ post.comments_count }}</v-card-text>
              </v-row>
            </v-col>
            <v-col cols="9">
              <v-row>
                <v-chip-group class="ml-3"><v-chip>{{ post.tags[0].name | omittedText5 }}</v-chip><v-chip>{{ post.tags[1].name | omittedText5 }}</v-chip><v-chip>{{ post.tags[2].name | omittedText5 }}</v-chip><v-chip>{{ post.tags[3].name | omittedText5 }}</v-chip><v-chip>{{ post.tags[4].name | omittedText5 }}</v-chip></v-chip-group>
              </v-row>
              <v-row>
                <v-card-text><p style="font-size:20px; line-height:28px">{{ post.summary.content | omittedText200 }}</p></v-card-text>
              </v-row>
            </v-col>
          </v-row>
          <v-row>
            <v-col cols="12">
            </v-col>
          </v-row>
        </v-card>
      </v-col>
    </v-row>
  </div>
</template>

<script>
export default {
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
