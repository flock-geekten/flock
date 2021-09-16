<template>
	<div>
		<h1>あそびを評価する</h1>	
		<v-card flat class="pa-10 my-5">
			<v-row>
				<v-col cols="5">
					<v-select
						v-model="hangout"
						:items="hangouts"
						outlined
						item-text="name"
						item-value="id"
						label="あそび"
						dense
						required
					/>
				</v-col>
				<v-col cols="7">
					<v-rating
						v-model="funScore"
						empty-icon="mdi-heart-outline"
						full-icon="mdi-heart"
						half-icon="mdi-heart-half-full"
						background-color="red lighten-3"
						color="red"
						></v-rating>
				</v-col>
			</v-row>
		</v-card>
		<div style="text-align:center">
			<v-btn 
			v-show="this.hangout === 0"
			disabled
			depressed 
			rounded 
			color="blue" 
			:ripple="false"
			>
			評価する
			</v-btn>
			<v-btn 
			v-show="this.hangout !== 0"
			depressed 
			rounded 
			color="blue ligthen-1" 
			dark 
			:ripple="false"
			@click="submit()"
			>
			評価する
			</v-btn>
		</div>
  </div>
</template>

<script>
import axios from 'axios'
export default{
	data(){
		return {
			hangouts: '',
			hangout: 0,
			funScore: 3,
		}
	},
	mounted(){
		this.$axios.get('/hangouts').then((response) => {
			this.hangouts = response.data
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
			this.createFun(this.hangout, this.funScore)
      this.$router.push("/review/confirm")
    }
  }
}
</script>