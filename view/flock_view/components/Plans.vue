<template>
  <div>
    <h3 v-show="plans.length === 0">現在予定されているあそびはありません</h3>
    <v-card
      flat
      v-show="plans.length !== 0"
      class="mx-auto"
      width="1000"
      max-width="1000"
      >
      <v-slide-group
        class="pa-4"
        show-arrows
        >
        <v-slide-item
          v-for="plan in plans" 
          :key="plan.plan.id"
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
                 id: plan.plan.id
                 }
                 }"
          >
          <v-card-title>{{ plan.plan.title | omittedText11 }}</v-card-title>
          <v-card-text><p>{{ plan.plan.body | omittedText80 }}</p></v-card-text>
          <v-card-text><v-icon class="mr-1" color="green">mdi-account-group-outline</v-icon>{{ plan.participations }}<v-icon class="ml-3 mr-1" color="orange">mdi-comment-outline</v-icon>{{ plan.comments_count }}</v-card-text>
          </v-card>
        </v-slide-item>
      </v-slide-group>
    </v-card>
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
       return text.length > 60 ? text.slice(0, 60) + "…" : text;
      },
      omittedText11(text) {
       // 11文字目以降は"…"
       return text.length > 11 ? text.slice(0, 11) + "…" : text;
      },
    },
  }
</script>

<style>
p {
  white-space: pre-wrap;
}
</style>
