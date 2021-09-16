<template>
  <div>
    <MyPage v-show="this.$device.isDesktopOrTablet" />
    <MyPageMobile v-show="this.$device.isMobile" />
  </div>
</template>

<script>
import MyPage from '../../components/MyPage.vue'
import MyPageMobile from '../../components/MyPageMobile.vue'

export default {
  components: {
    MyPage,
    MyPageMobile,
  },
}
</script>
