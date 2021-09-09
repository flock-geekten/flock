<template>
  <div>
    <v-card
      class="mx-auto"
      max-width="300"
      tile
      flat
      :ripple="false"
      >
      <v-list shaped color="blue-grey lighten-5">
        <v-subheader>メニュー</v-subheader>
        <v-list-item-group
          color="primary"
          >
          <v-list-item
            v-for="(item, i) in items"
            :key="i"
            >
            <v-list-item-icon>
              <v-icon v-text="item.icon"></v-icon>
            </v-list-item-icon>
          <v-list-item-content>
            <v-list-item-title v-text="item.text"></v-list-item-title>
          </v-list-item-content>
          </v-list-item>
        </v-list-item-group>
      </v-list>
    </v-card>
  </div>
</template>

<script>
export default {
  data () {
    return {
      items: [
        { text: "ホーム" },
        { text: "あそび一覧" }
      ]
    }
  }
}
</script>
