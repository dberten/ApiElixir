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
		this.userId = localStorage.getItem('s_userId')
	},
}

</script>

<template>

	<div class="d-flex mb-5 navBox flex-row justify-content-between">

		<img alt="Vue logo" class="ps-3" src="./assets/logo.svg" width="50" height="50" />
		<span class="pe-3 d-flex align-items-end ">
			
			<router-link :to="{ name: 'Mes Heures', params: { userId: this.userId } }" class="mx-3 text-color-Wsoft navBox-text">
				<h5>Mes Heures</h5>
			</router-link>
			<!-- <router-link to="/currentWeather/Lyon" v-bind:to="selected"><h5>Current Weather</h5></router-link> -->

			<router-link to="/ClockManager/1" class="mx-3 text-color-Wsoft navBox-text">
				<h5>Clock Manager</h5>
			</router-link>
			<router-link to="/user" class="mx-3 text-color-Wsoft navBox-text">
				<h5>user</h5>
			</router-link>

		</span>
	</div>
	<router-view />

	<!-- <CurrentWeather town="Lyon" temperature="12°C" /> -->
	<!-- <CurrentWeather /> -->
</template>