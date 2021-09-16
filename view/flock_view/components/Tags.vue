<template>
  <div>
    <v-card flat class="pa-3 my-3" color="blue lighten-4" rounded="lg">
      <div v-for="tag in tags" :key="tag.id">
        <v-chip 
          class="my-1" 
          :to="{
            name: 'tags-id',
            params: {
              id: tag.id
            }
          }"
          >
          # {{ tag.name | omittedText8 }}
        </v-chip>
      </div>
    </v-card>
  </div>
</template>

<script>
export default {
  props: {
    tags: Object
  },
  filters: {
    omittedText8(text) {
     // 15文字目以降は"…"
     return text.length > 8 ? text.slice(0, 8) + "…" : text;
    },
  },
}
</script>
