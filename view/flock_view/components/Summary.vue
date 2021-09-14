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
      <h3>要約</h3>
      <v-sheet class="pa-10">
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
      </v-sheet>
    </div>
    <div v-show="editSummaryFlag === false">
      <h3 class="mb-3">要約</h3>
      <v-sheet class="pa-10" color="#EEEEEE">
        <div
          v-show="summary === ''"
          style="text-align:center"
          >
        <v-progress-circular
          indeterminate
          color="blue lighten-1"
         />
        </div>
        <div v-show="summary !== ''">
          <p>{{ summary }}</p>
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
        </div>
      </v-sheet>

      <!-- タグ -->
      <h3 class="mt-10 mb-3">タグ</h3>
      <v-sheet color="#EEEEEE">
        <v-container>
          <v-row>
            <v-col v-for="(keyPhrase, index) in keyPhrases" :key="index">
              <v-text-field
                v-model="keyPhrases[index]"
                outlined
                rounded
                dense
                prefix="# "
                ></v-text-field>
            </v-col>
          </v-row>
        </v-container>
      </v-sheet>
    </div>

    <!-- タグ編集ダイアログ -->
    <v-dialog>

    </v-dialog>

    <!-- 記事 -->
    <v-sheet class="pa-15 my-15">
      <h1>{{ title }}</h1>
      <br>
      <v-divider />
      <br>
      <p>{{ body }}</p>
    </v-sheet>
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
        rounded
        depressed
        color="blue lighten-1"
        dark
        :ripple="false"
        @click="createPost()"
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
        rounded
        depressed
        color="blue lighten-1"
        dark
        :ripple="false"
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
      body: String,
      summary: String,
      keyPhrases: Object,
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
            this.createSummary(id, this.summary)
            for (let i=0; i < 5; i++){
              this.createTag(id, this.keyPhrases[i])
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
          response => {
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
</style>
