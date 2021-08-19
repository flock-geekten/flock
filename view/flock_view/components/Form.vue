<template>
  <div>
    <v-row>
      <v-col>
        <v-sheet>
          <v-text-field
            v-model="post.title"
            label="タイトル"
            outlined
            clearable
          />
          <v-divider />
          <br>
          <v-textarea
            v-model="post.body"
            height="500"
            label="本文"
            value="自動生成された文章を入れる"
            outlined
            counter
          />
          <v-combobox
            v-model="select"
            :items="tags"
            item-text="name"
            item-value="id"
            label="タグ"
            multiple
            outlined
            chips
          />
        </v-sheet>
      </v-col>
    </v-row>
    <v-row>
      <v-col>
        <v-btn
          rounded
          depressed
          outlined
          dark
          color="blue"
          @click="updatePost()"
          >完了
        </v-btn>
        <v-btn
          rounded
          depressed
          outlined
          dark
          color="red"
          @click="deleteDialog = true"
          >記事の削除
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
            <h3><font font-color="#ffffff">本当に削除してよろしいですか？</font></h3>
          </div>
        </v-card-text>
        <v-card-actions>
          <v-spacer></v-spacer>
          <v-btn
            color="blue"
            rounded
            depressed
            dark
            @click="dialog = false"
            >
            いいえ
          </v-btn>
          <v-btn
            color="red"
            rounded
            depressed
            dark
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
import axios from 'axios'
import moment from 'moment'
  export default {
    props: {
      post: Object
    },
    data () {
      return {
        select: [],
        tags: [],
        createdAt: moment(this.post.created_at).format('YYYY年MM月DD日'),
        updatedAt: moment(this.post.updated_at).format('YYYY年MM月DD日'),
        deleteDialog: false
      }
    },
    mounted() {
      const url = 'http://localhost:3000' + '/tags'
      axios.get(url, {
        headers: { 
          "Content-Type": "application/json", 
        }
      })
        .then(response => {
          this.tags = response.data
        })
    },
    methods: {
      changeEditFlag: function(){
        this.$emit('changeEditFlag')
      },
      // 編集メソッド
      updatePost: function(){
        const updatePostUrl = 'http://localhost:3000' + '/posts/' + this.post.id + '?title=' + this.post.title + '&body=' + this.post.body;
        axios.defaults.headers.common['Content-Type'] = 'application/json';
        axios.put(updatePostUrl).then(
          this.changeEditFlag()
        )
      },
      // 削除メソッド
      destroyPost: function(){
        const destroyPostUrl = 'http://localhost:3000' + '/posts/' + this.post.id
        axios.delete(destroyPostUrl).then(
          this.$router.push('/')
        )
      }
    }
  }
</script>
