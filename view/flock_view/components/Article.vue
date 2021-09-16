<template>
  <div>
    <!-- <p style="font-size:20px; line-height:36px">{{ post.body }}</p> -->
		<div v-html="$md.render(body)"></div>
  </div>
</template>

<script>
import moment from 'moment'
  export default {
    props: {
      post: {
				type: Object,
				default: () => ('')
			},
			body: {
				type: String,
				default: () => ('')
			}
    },
  }
</script>

<style>
h1 {
	font-size: 26px;
	margin-top: 30px;
	margin-bottom: 10px;
	background: linear-gradient(transparent 90%, #a8eaff 90%);
}
h2 {
	font-size: 22px;
	margin-top: 20px;
	margin-bottom: 10px;
	margin-bottom: 10px;
}
h3 {
	font-size: 18px;
	margin-top: 20px;
	margin-bottom: 10px;
}
h4 {
	font-size: 16px;
	margin-top: 20px;
	margin-bottom: 10px;
}
h5 {
	font-size: 14px;
	margin-top: 20px;
	margin-bottom: 10px;
}
h6 {
	font-size: 12px;
	margin-top: 20px;
	margin-bottom: 10px;
}
p {
  white-space: pre-wrap;
	font-size: 20px;
	line-height: 36px;
}
li{
	font-size: 20px;
	line-height: 36px;
}
</style>
