<template>
  <div>
    <h3 v-show="plans.length === 0">現在予定されているあそびはありません</h3>
    <v-sheet
      v-show="plans.length !== 0"
      class="mx-auto"
      width="1000"
      max-width="1000"
      flat
      >
      <v-slide-group
        class="pa-4"
        show-arrows
        >
        <v-slide-item
          v-for="plan in plans" 
          :key="plan.id"
          v-slot="{ active, toggle }"
          >
          <v-card 
          class="ma-3 pa-3"
          flat
          color="blue-grey lighten-5"
          :ripple="false"
          height="200"
          width="300"
          :to="{
                 name: 'plans-id',
                 params: {
                 id: plan.id
                 }
                 }"
          >
          <v-card-title>{{ plan.title | omittedText11 }}</v-card-title>
          <v-card-text>{{ plan.body | omittedText80 }}</v-card-text>
          </v-card>
        </v-slide-item>
      </v-slide-group>
    </v-sheet>
  </div>
</template>

<script>
  export default {
    props: {
      plans: Array,
    },
    filters: {
      omittedText80(text) {
       // 80文字目以降は"…"
       return text.length > 80 ? text.slice(0, 80) + "…" : text;
      },
      omittedText11(text) {
       // 11文字目以降は"…"
       return text.length > 11 ? text.slice(0, 11) + "…" : text;
      },
    },
  }
</script>
