<template>
  <div id="app">
    <navbar></navbar>
    <v-app>
      <p>{{ message }}</p>
      <user />
    </v-app>
    <footerbottom></footerbottom>
  </div>
</template>

<script>
import user from "./packs/components/user";
import navbar from "./packs/components/navbar";
import footerbottom from "./packs/components/footerbottom";

export default {
  data: function() {
    return {
      message: "Hello Vue!",
    };
  },
  components: {
    user: user,
    navbar: navbar,
    footerbottom: footerbottom,
  },
};
</script>

<style scoped>
p {
  font-size: 2em;
  text-align: center;
}
</style>
