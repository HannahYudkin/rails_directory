<template>
  <div>
    <v-toolbar
      v-img
      dark
      prominent
      :src="require('../assets/HeartBackground.jpg')"
    >
      <!-- <v-app-bar-nav-icon></v-app-bar-nav-icon> -->

      <v-spacer></v-spacer>
      <v-toolbar-title class="title">Directory</v-toolbar-title>
      <v-spacer></v-spacer>
      <!-- <v-btn icon>
        <v-icon>mdi-export</v-icon>
      </v-btn> -->
    </v-toolbar>
  </div>
</template>

<style scoped>
.title {
  font-size: 50px;
  text-shadow: 2px 2px #462226;
}
</style>
