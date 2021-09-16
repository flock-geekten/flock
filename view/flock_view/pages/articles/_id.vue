<template>
  <div>
    <ArticleShow v-show="this.$device.isDesktopOrTablet" />
    <ArticleShowMobile v-show="this.$device.isMobile" />
  </div>
</template>

<script>
import ArticleShow from '../../components/ArticleShow.vue'
import ArticleShowMobile from '../../components/ArticleShowMobile.vue'
export default {
  components: {
    ArticleShow,
    ArticleShowMobile,
  },
}
</script>
