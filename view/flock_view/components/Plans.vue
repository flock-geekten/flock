<template>   
  <div>
    <v-list
        class="overflow-y-auto mx-auto"
        color="grey lighten-3"
        width="100%"
        height="300"
        max-height="300"
        max-width="100%">
        
        <v-list-item v-show="plans.length === 0">
          <h3>現在予定されているあそびはありません</h3>
        </v-list-item>
        <v-list-item
            v-show="plans.length !== 0"
            v-for="plan in plans"
            :key="plan.plan.id">
            <v-card 
              class="pa-3 my-1" 
              width="100%"
              flat
              :ripple="false"
              :to="{
                name: 'plans-id',
                params: {
                  id: plan.plan.id
                }
              }"
              >
              <v-card-text>
                <v-row>
                  <h2>{{ plan.plan.title | omittedText25 }}</h2>
                  <v-spacer />
                    <v-icon class="mr-1" color="green">mdi-account-group-outline</v-icon>{{ plan.participations }}<v-icon class="ml-3 mr-1" color="orange">mdi-comment-outline</v-icon>{{ plan.comments_count }}
                </v-row>
              </v-card-text>
            </v-card>
        </v-list-item>
    </v-list>
  </div>
</template>

<script>
  export default {
    props: {
      plans: Array,
    },
    filters: {
      omittedText25(text) {
       return text.length > 25 ? text.slice(0, 25) + "…" : text;
      },
    },
  }
</script>

<style>
p {
  white-space: pre-wrap;
}
</style>
