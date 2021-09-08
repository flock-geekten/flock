<template>
  <div>
    <h1 class="py-5">普段よくするあそびを選択してください</h1>

    <v-row>
      <v-col cols="2" v-for="s in selected" :key=s>
        <div>
          <v-chip>{{ s }}</v-chip>
        </div>
      </v-col>
    </v-row>

    <br>

    <v-sheet class="pa-5">
      <v-row>
        <v-col cols="2" v-for="hangout in hangouts" :key="hangout">
          <v-checkbox
            v-model="selected"
            :label="hangout"
            :value="hangout"
          ></v-checkbox>
        </v-col>
      </v-row>
    </v-sheet>
    
    <br>

    <div class="text-center">
      <v-btn
        rounded
        depressed
        dark
        color="blue lighten-1"
        to="/"
        >
        決定
      </v-btn>
    </div>

  </div>
</template>

<script>
  export default {
    data () {
      return {
        hangouts: ['サッカー', 'バスケ', '野球', '釣り', '飲み会'],
        selected: [],
      }
    },
  }
</script>
