<template>
  <div>
    <MyPage v-show="this.$device.isDesktop" />
    <MyPageMobile v-show="this.$device.isMobileOrTablet" />
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
