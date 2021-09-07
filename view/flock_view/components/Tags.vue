<template>
  <div>
    <v-sheet class="pa-3 my-3" color="blue lighten-4" rounded="lg">
      <div v-for="tag in tags" :key="tag.id">
        <v-chip class="my-1"># {{ tag.name | omittedText15 }}</v-chip>
      </div>
    </v-sheet>
  </div>
</template>

<script>
export default {
  props: {
    tags: Object
  },
  filters: {
    omittedText15(text) {
     // 15文字目以降は"…"
     return text.length > 15 ? text.slice(0, 15) + "…" : text;
    },
  },
}
</script>
