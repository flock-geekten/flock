<template>
  <div>
    <!-- アラート -->
    <v-alert
      dense
      text
      type="success"
      class="pa-5 my-5"
    >こちらで内容で投稿します。よろしいですか？</v-alert>
    
    <!-- 要約 -->
    <div v-show="editSummaryFlag === true">
      <h2>要約</h2>
      <v-card flat class="pa-5">
      <v-textarea
        v-model="summary"
        height="150"
        label="要約"
        outlined
        counter
      />
      <v-btn
        rounded
        depressed
        color="red"
        dark
        :ripple="false"
        @click="editSummaryFlag=false"
      >
        完了
      </v-btn>
      </v-card>
    </div>
    <div v-show="editSummaryFlag === false">
      <h2 class="mb-3">要約</h2>
      <v-card flat class="pa-5" color="#EEEEEE">
        <div
          v-show="summary.length === 0"
          style="text-align:center"
          >
        <v-progress-circular
          indeterminate
          color="blue lighten-1"
         />
        </div>
        <div v-show="summary.length !== 0">
          <p>{{ summary }}</p>
        </div>
				<v-btn
					rounded
					depressed
					color="blue lighten-1"
					dark
					:ripple="false"
					@click="editSummaryFlag = true"
				>
					編集
				</v-btn>
      </v-card>

      <!-- タグ -->
      <h2 class="mt-10 mb-3">タグ</h2>
      <v-card flat color="#EEEEEE" class="py-3" v-show="this.$device.isDesktop">
        <v-container>
          <v-row>
            <v-col>
              <v-text-field
                v-model="keyPhrases0"
                outlined
                rounded
                dense
                prefix="# "
                ></v-text-field>
            </v-col>
						<v-col>
              <v-text-field
                v-model="keyPhrases1"
                outlined
                rounded
                dense
                prefix="# "
                ></v-text-field>
						</v-col>
						<v-col>
              <v-text-field
                v-model="keyPhrases2"
                outlined
                rounded
                dense
                prefix="# "
                ></v-text-field>
						</v-col>
						<v-col>
              <v-text-field
                v-model="keyPhrases3"
                outlined
                rounded
                dense
                prefix="# "
                ></v-text-field>
						</v-col>
						<v-col>
              <v-text-field
                v-model="keyPhrases4"
                outlined
                rounded
                dense
                prefix="# "
                ></v-text-field>
            </v-col>
          </v-row>
        </v-container>
      </v-card>
      <v-card flat color="#EEEEEE" v-show="this.$device.isMobileOrTablet" class="pa-3">
        <v-container>
            <v-row>
              <v-text-field
                v-model="keyPhrases0"
                outlined
                rounded
                dense
                prefix="# "
                ></v-text-field>
              <v-text-field
                v-model="keyPhrases1"
                outlined
                rounded
                dense
                prefix="# "
                ></v-text-field>
              <v-text-field
                v-model="keyPhrases2"
                outlined
                rounded
                dense
                prefix="# "
                ></v-text-field>
              <v-text-field
                v-model="keyPhrases3"
                outlined
                rounded
                dense
                prefix="# "
                ></v-text-field>
              <v-text-field
                v-model="keyPhrases4"
                outlined
                rounded
                dense
                prefix="# "
                ></v-text-field>
          </v-row>
        </v-container>
      </v-card>
    </div>

    <!-- 記事 -->
    <v-card flat class="pa-15 my-5">
			<div class="post-title">{{ title }}</div>
			<p v-show="this.$device.isMobileOrTablet" style="font-size:20px; line-height:36px">{{ body }}</p>
			<div v-show="this.$device.isDesktop" v-html="$md.render(body)"></div>
    </v-card>
    <div v-show="mode===1" class="text-center">
      <v-btn
        rounded
        depressed
        outlined
        dark
        color="red"
        :ripple="false"
        @click="offSummaryFlag();onEditFlag()"
      >
        戻る
      </v-btn>
      <v-btn
				v-show="title.length !== 0 && body.length !== 0 && summary.length !== 0"
        rounded
        depressed
        color="blue lighten-1"
        dark
        :ripple="false"
        @click="createPost()"
      >
        投稿
      </v-btn>
      <v-btn
				v-show="title.length === 0 || body.length === 0 || summary.length === 0"
        rounded
        depressed
        color="blue lighten-1"
				disabled
      >
        投稿
      </v-btn>
    </div>
    <div v-show="mode===2" class="text-center">
      <v-btn
        rounded
        depressed
        outlined
        dark
        :ripple="false"
        color="red"
        @click="offSummaryFlag();onEditFlag()"
      >
        戻る
      </v-btn>
      <v-btn
				v-show="title.length !== 0 && body.length !== 0 && summary.length !== 0"
        rounded
        depressed
        color="blue lighten-1"
        dark
        :ripple="false"
        @click="updatePost()"
      >
        完了
      </v-btn>
      <v-btn
				v-show="title.length === 0 || body.length === 0 || summary.length === 0"
        rounded
        depressed
        color="blue lighten-1"
				disabled
        @click="updatePost()"
      >
        完了
      </v-btn>
    </div>
  </div>
</template>

<script>
  import axios from 'axios'
  export default {
    props: {
      mode: Number, // 1: 新規投稿, 2: 投稿編集
      id: Number, // 0: 新規作成時, それ以外: postのid
      title: String,
			body: {
				type: String,
				default: () => ('')
			},
      summary: String,
      keyPhrases0: String,
      keyPhrases1: String,
      keyPhrases2: String,
      keyPhrases3: String,
      keyPhrases4: String,
    },
    data () {
      return {
        editSummaryFlag: false,
      }
    },
    methods: {
      onEditFlag: function(){
        this.$emit('onEditFlag')
      },
      offEditFlag: function(){
        this.$emit('offEditFlag')
      },
      onSummaryFlag: function(){
        this.$emit('onSummaryFlag')
      },
      offSummaryFlag: function(){
        this.$emit('offSummaryFlag')
      },
      // 記事の投稿
      createPost: function(){
        const createPostUrl = this.$apiBaseUrl + '/posts'
        axios.defaults.headers.common['Content-Type'] = 'application/json';
        var params = new URLSearchParams();
        params.append('title', this.title);
        params.append('body', this.body);
        params.append('uid', this.$store.state.user.uid);
        axios.post(createPostUrl, params).then(
          response => {
            var id = response.data.id
						var keyPhrases = [this.keyPhrases0, this.keyPhrases1, this.keyPhrases2, this.keyPhrases3, this.keyPhrases4]
            this.createSummary(id, this.summary)
            for (let i=0; i < 5; i++){
              this.createTag(id, keyPhrases[i])
            }
            this.$router.push('/articles/confirm')
          }
        )
      },
      // タグの作成
      createTag: function(post_id, tag_name){
        const createTagUrl = this.$apiBaseUrl + '/post_tags'
        axios.defaults.headers.common['Content-Type'] = 'application/json';
        var params = new URLSearchParams();
        params.append('post_id', post_id);
        params.append('tag_name', tag_name);
        axios.post(createTagUrl, params)
      },
      // タグの編集
      updateTag: function(id, tag_name){
        const updateTagUrl = this.$apiBaseUrl + '/post_tags/' + id
        axios.defaults.headers.common['Content-Type'] = 'application/json';
        var params = {
          tag_name: tag_name
        }
        axios.put(updateTagUrl, params)
      },
      // 要約文の作成
      createSummary: function(id, summary){
        const createSummaryUrl = this.$apiBaseUrl + '/posts/' + id + '/summaries'
        var params = new URLSearchParams();
        params.append('content', summary);
        params.append('post_id', id);
        axios.post(createSummaryUrl, params)
      },
      // 記事の編集
      updatePost: function(){
        const updatePostUrl = '/posts/' + this.id
        var updateParams = {
          title: this.title,
          body: this.body
        }
        this.$axios.defaults.headers.common['Content-Type'] = 'application/json';
        this.$axios.put(updatePostUrl, updateParams).then(
          (response) => {
            var tagList = response.data
						var keyPhrases = [this.keyPhrases0, this.keyPhrases1, this.keyPhrases2, this.keyPhrases3, this.keyPhrases4]
            for( var i=0; i<tagList.length; i++){
              this.updateTag(tagList[i], keyPhrases[i])
            } 
            const updateSummaryUrl = '/posts/' + this.id + '/summaries'
            var updateSummaryParams = {
              content: this.summary,
              post_id: this.id
            }
            this.$axios.put(updateSummaryUrl, updateSummaryParams)
            this.$router.push('/articles/confirm')
          }
        )
      }
    }
  }
</script>

<style>
p {
  white-space: pre-wrap;
}
.post-title{
	font-weight: bolder;
	font-size: 40px;
  margin-top: 50px;	
  margin-bottom: 50px;	
}
</style>