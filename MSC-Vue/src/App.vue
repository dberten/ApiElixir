<script>
  import CurrentWeather from './components/CurrentWeather.vue';
  import BootstrapVue from "bootstrap-vue"

  import "bootstrap/dist/css/bootstrap.min.css"
  import "bootstrap-vue/dist/bootstrap-vue.css"

  export default {
    // components: {CurrentWeather}
  }
  
</script>

<template>
    <header class="black">
      <img alt="Vue logo" class="logo" src="./assets/logo.svg" width="125" height="125" />

          <div id="nav">
            <router-link to="/user">user</router-link> |
            <router-link to="/currentWeather/Lyon" v-bind:to="selected">Current Weather</router-link>
          </div>
          <router-view/>

      <div class="">
        <!-- <CurrentWeather town="Lyon" temperature="12°C" /> -->
        <!-- <CurrentWeather /> -->

      </div>
    </header>
</template>