<template>
	<div>
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
			 <v-card-title><h2>{{ post.post.title | omittedText8 }}</h2><v-spacer /></v-card-title>
			 <v-card-text><v-icon class="mr-1" color="pink">mdi-heart-outline</v-icon>{{ post.likes_count }}<v-icon class="ml-3 mr-1" color="orange">mdi-comment-outline</v-icon>{{ post.comments_count }}</v-card-text>
		   </v-row>

		   <v-row>
			 <v-card-text><p style="font-size:20px">{{ post.summary.content | omittedText85 }}</p></v-card-text>
		   </v-row>
		</v-card>

	</div>
</template>

<script>
export default{
  props: {
    post: Object
  },
  filters: {
    omittedText8(text) {
     return text.length > 8 ? text.slice(0, 8) + "…" : text;
    },
    omittedText85(text) {
     return text.length > 85 ? text.slice(0, 85) + "…" : text;
    },
  },
}
</script>