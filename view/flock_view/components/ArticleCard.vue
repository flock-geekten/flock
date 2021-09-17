<template >
    <div>
			<v-hover>
				<template v-slot:default="{hover}">
					<v-card 
						color="white" 
						flat
						rounded
						:elevation="hover ? 1: 0"
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
							<v-card-title>
								<v-avatar size="36" color="blue ligthen-1" dark class="mr-2">
									<span class="white--text text-h5">{{ post.flock }}</span>
								</v-avatar>
								<h2>{{ post.post.title | omittedText28 }}</h2>
								<v-spacer />
							</v-card-title>
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
							</v-col>
							<v-col cols="9">
								<v-row>
									<v-chip-group class="ml-3">
										<v-chip :to="{name: 'tags-id', params: { id:post.tags[0].id }}">{{ post.tags[0].name | omittedText5 }}</v-chip>
										<v-chip :to="{name: 'tags-id', params: { id:post.tags[1].id }}">{{ post.tags[1].name | omittedText5 }}</v-chip>
										<v-chip :to="{name: 'tags-id', params: { id:post.tags[2].id }}">{{ post.tags[2].name | omittedText5 }}</v-chip>
										<v-chip :to="{name: 'tags-id', params: { id:post.tags[3].id }}">{{ post.tags[3].name | omittedText5 }}</v-chip>
										<v-chip :to="{name: 'tags-id', params: { id:post.tags[4].id }}">{{ post.tags[4].name | omittedText5 }}</v-chip>
										<v-icon class="mr-1" color="pink">mdi-heart</v-icon>{{ post.likes_count }}
										<v-icon class="ml-3 mr-1" color="orange">mdi-comment</v-icon>{{ post.comments_count }}
										</v-chip-group>
								</v-row>
								<v-row>
									<v-card-text><div style="font-size:20px; line-height:28px">{{ post.summary.content | omittedText200 }}</div></v-card-text>
								</v-row>
							</v-col>
						</v-row>
					</v-card>
				</template>
			</v-hover>
    </div>
</template>

<script>
export default{
  props: {
    post: Object
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
    omittedText28(text) {
     // 80文字目以降は"…"
     return text.length > 28 ? text.slice(0, 28) + "…" : text;
    },
  },
}
</script>

<style>
.flock{
	font-weight: bold;
	font-size: 18px;
	margin-bottom: 20px; 
}
</style>