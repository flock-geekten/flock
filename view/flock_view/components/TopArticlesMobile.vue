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
             <v-card-text><p style="font-size:20px">{{ post.summary.content | omittedText200 }}</p></v-card-text>
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
