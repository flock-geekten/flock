<template>
  <div>
    <v-row>
      <v-col>
        <v-text-field
          v-model="post.title"
          label="タイトル"
          flat
          solo
          class="mt-5"
        />
        <v-textarea
          v-model="post.body"
          height="500"
          label="本文"
          value="自動生成された文章を入れる"
          flat
          solo
          counter
        />
      </v-col>
    </v-row>
    <v-row>
      <v-col>
        <v-btn
          rounded
          depressed
          outlined
          dark
          color="blue lighten-1"
          :ripple="false"
          @click="offEditFlag()"
          >戻る
        </v-btn>
        <v-btn
          rounded
          depressed
          outlined
          dark
          color="red"
          :ripple="false"
          @click="deleteDialog = true"
          >記事の削除
        </v-btn>
        <v-btn
          rounded
          depressed
          dark
          color="blue"
          :ripple="false"
          @click="offEditFlag();onSummaryFlag()"
          >編集
        </v-btn>
      </v-col>
    </v-row>
    <v-dialog
      v-model="deleteDialog"
      width="500"
      >
      <v-card>
        <v-card-text>
          <div class="pt-10">
            <h2><font font-color="#ffffff">本当に削除してよろしいですか？</font></h2>
          </div>
        </v-card-text>
        <v-card-actions>
          <v-spacer></v-spacer>
          <v-btn
            color="blue"
            rounded
            depressed
            dark
            :ripple="false"
            @click="deleteDialog=false"
            >
            いいえ
          </v-btn>
          <v-btn
            color="red"
            rounded
            depressed
            dark
            :ripple="false"
            @click="destroyPost()"
            >
            はい
          </v-btn>
        </v-card-actions>
      </v-card>
    </v-dialog>
  </div>
</template>

<script>
import moment from 'moment'
  export default {
    props: {
      post: Object
    },
    data () {
      return {
        title: '',
        body: '',
        select: [],
        tags: [],
        createdAt: moment(this.post.created_at).format('YYYY年MM月DD日'),
        updatedAt: moment(this.post.updated_at).format('YYYY年MM月DD日'),
        deleteDialog: false
      }
    },
    mounted() {
      const url = '/tags'
      this.$axios.get(url, {
        headers: { 
          "Content-Type": "application/json", 
        }
      })
        .then(response => {
          this.tags = response.data
        })
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
      // 削除メソッド
      destroyPost: function(){
        const destroyPostUrl = '/posts/' + this.post.id
        this.$axios.delete(destroyPostUrl).then(
          this.$router.push('/')
        )
      }
    }
  }
</script>
