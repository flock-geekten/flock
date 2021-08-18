<template>
  <div>
    <div v-if="editFlag===false">
      <v-row>
        <v-col>
          <v-sheet>
            <p>投稿日：{{ createdAt }} | 最終更新日：{{ updatedAt }}</p>
            <h1>{{ post.title }}</h1>
            <br>
            <v-divider />
            <br>
            <p>{{ post.body }}</p>
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
            @click="changeEditFlag()"
            >編集
          </v-btn>
        </v-col>
      </v-row>
    </div>
    <div v-else>
      <Form 
        :post="post"
        @changeEditFlag="changeEditFlag"
        />
    </div>
    <br>
    <v-btn
      rounded
      depressed
      dark
      color="blue lighten-1"
      to='/'
      >←TOP
    </v-btn>
  </div>
</template>

<script>
import axios from 'axios'
import moment from 'moment'
import Menu from '../../components/Menu.vue'
import Form from '../../components/Form.vue'
export default {
  components: {
    Menu,
    Form
  },
  data () {
    return {
      post: '',
      createdAt: '',
      updatedAt: '',
      editFlag: false
    }
  },
  mounted() {
    const url = 'http://localhost:3000' + '/posts/' + this.$route.params.id
    axios.get(url, {
      headers: { 
        "Content-Type": "application/json", 
      }
    })
      .then(response => {
        this.post = response.data
        this.createdAt = moment(this.post.created_at).format('YYYY年MM月DD日') 
        this.updatedAt = moment(this.post.updated).format('YYYY年MM月DD日') 
      })
  },
  methods: {
    changeEditFlag: function(){
      this.editFlag = !this.editFlag
    }
  }
}
</script>
<style>
p {
  white-space: pre-wrap;
}
</style>
