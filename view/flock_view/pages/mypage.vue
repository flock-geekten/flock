<template>
  <p>{{ message }}</p>
</template>
<script>
import firebase from '~/plugins/firebase'

export default {
  data: () => {
    return {
      message: ''
    }
  },

  mounted() {
    console.log(firebase.auth())
    this.message = firebase.auth()
  }
}
</script>
