<template>
  <div>
    <UserShow v-show="this.$device.isDesktopOrTablet" />
    <UserShowMobile v-show="this.$device.isMobile" />
  </div>
</template>

<script>
import axios from 'axios'
import UserShow from '../../components/UserShow.vue'
import UserShowMobile from '../../components/UserShowMobile.vue'
export default {
  components: {
    UserShow,
    UserShowMobile,
  },
}
</script>
