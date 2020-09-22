<template>
  <v-card height="150">
    <v-footer
      absolute
      class="font-weight-medium"
      :src="require('../assets/HeartBackground.jpg')"
    >
      <v-col class="text-center" cols="12" align="center" justify="center">
        {{ new Intl.DateTimeFormat("en-US", { month: "long" }).format(date) }}
        {{ new Date().getDate() }}, {{ new Date().getFullYear() }} -
        <strong>Hannah Yudkin </strong>
      </v-col>
    </v-footer>
  </v-card>
</template>

<style scoped>
.font-weight-medium {
  background-image: url("../assets/HeartBackground.jpg");
  background-size: 100%;
}
</style>
