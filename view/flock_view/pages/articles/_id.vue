<template>
  <div>
    <div v-if="editFlag===false">
      <v-row>
        <v-col>
          <Article :post="post" />
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
import Article from '../../components/Article.vue'
import Form from '../../components/Form.vue'
export default {
  components: {
    Menu,
    Article,
    Form
  },
  data () {
    return {
      post: '',
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
      })
  },
  methods: {
    changeEditFlag: function(){
      this.editFlag = !this.editFlag
    }
  }
}
</script>
