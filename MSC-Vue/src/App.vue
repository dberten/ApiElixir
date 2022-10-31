<script>
  import CurrentWeather from './components/CurrentWeather.vue';

  import "bootstrap/dist/css/bootstrap.css"
  import "bootstrap/dist/js/bootstrap.bundle.js"
  

  export default {
    // components: {CurrentWeather}
    data() {
		return {
			userId: null,
		}
    },
    created() {
      	this.userId = localStorage.getItem('userId')
    },
  }
  
</script>

<template>
    <header class="black">
      <img alt="Vue logo" class="logo" src="./assets/logo.svg" width="125" height="125" />

          <div id="nav">
            <router-link to="/user">user</router-link> |
    <div v-if="userId">
            <router-link :to="{ name: 'Mes Heures', params: { userId: this.userId }}">Mes Heures</router-link> |
    </div>
            <router-link to="/currentWeather/Lyon" v-bind:to="selected">Current Weather</router-link>
          </div>
          <router-view/>

      <div class="">
        <!-- <CurrentWeather town="Lyon" temperature="12°C" /> -->
        <!-- <CurrentWeather /> -->

      </div>
    </header>
</template>