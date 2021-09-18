<template>
  <div>
    <v-card flat class="pa-15">
      <div style="text-align:center">
        <div class="post-title">ログアウトしました</div>
        <br>
        <v-btn
          rounded
          depressed
          dark
          color="blue lighten-1"
          to='/'
          :ripple="false"
          >←TOP
        </v-btn>
      </div>
    </v-card>
  </div>
</template>

<style>
.post-title{
	font-weight: bolder;
	font-size: 40px;
  margin-top: 50px;	
  margin-bottom: 50px;	
}
</style>