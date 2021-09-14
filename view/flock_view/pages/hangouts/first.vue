<template>
  <div>
    <h1 class="py-5">以下のあそびの好き度を入力してください</h1>
    <p>ハートが多い方が好きになるように入力してください</p>
    <br>

    <v-card flat class="pa-5">
      <v-container>
        <v-row v-for="(hangout, index) in hangouts" :key="hangout.id">
          <v-col cols="3">
            {{ hangout.name }}
          </v-col>
          <v-col cols="9">
            <v-rating
              v-model="funScore[index]"
              empty-icon="mdi-heart-outline"
              full-icon="mdi-heart"
              half-icon="mdi-heart-half-full"
              background-color="red lighten-3"
              color="red"
              ></v-rating>
          </v-col>
        </v-row>
      </v-container>
    </v-card>
    
    <br>

    <div class="text-center">
      <v-btn
        rounded
        depressed
        dark
        color="blue lighten-1"
        :ripple="false"
        @click="submit()"
        >
        決定
      </v-btn>
    </div>

  </div>
</template>

<script>
import axios from 'axios'
  export default {
    data () {
      return {
        hangouts: '',
        funScore: [3, 3, 3, 3, 3],
      }
    },
    mounted() {
      this.$axios.get('/hangouts', {
        headers: { 
          "Content-Type": "application/json", 
        }
      })
        .then(response => {
          this.hangouts = [response.data[53], response.data[14], response.data[19], response.data[11]]
        })
    },
    methods: {
      createFun: function(hangoutId, score){
        const createFunUrl = this.$apiBaseUrl + '/api/v1/score'
        var params = new URLSearchParams();
        params.append('user_id', this.$store.state.user.userId);
        params.append('hangout_id', hangoutId);
        params.append('fun_score', score);
        axios.post(createFunUrl, params)
      },
      submit: function(){
        for (var i=0; i < this.hangouts.length; i++){
          this.createFun(this.hangouts[i].id, this.funScore[i])
        }
        this.$router.push("/hangouts/ready")
      }
    }
  }
</script>
