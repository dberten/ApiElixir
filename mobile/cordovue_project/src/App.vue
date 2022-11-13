<script>
import "bootstrap/dist/css/bootstrap.css"
import "bootstrap/dist/js/bootstrap.bundle.js"


export default {
	data() {
		return {
			navbar: false,
		}
	},
	created() {
		this.userId = localStorage.getItem('s_userId')
	},
	methods: {
        Deconnexion() {
            sessionStorage.removeItem('sessionObject')
			document.location.reload();
        }
	},
	mounted() {
		const sessionObject = JSON.parse(sessionStorage.getItem('sessionObject'));
		if (sessionObject != null) {
			this.navbar = sessionObject.SessionData.navbar;
		}
	}
}

</script>

<template>

	<div class="d-flex mb-5 navBox flex-row justify-content-between" v-if="this.navbar == true">

		<img alt="Vue logo" class="ps-3" src="./assets/logo.svg" width="50" height="50" />
		<span class="pe-3 d-flex align-items-end ">

			<router-link to="/" class="mx-3 text-color-Wsoft navBox-text">
				<h5>Mes Heures</h5>
			</router-link>
			<router-link to="/Clock" class="mx-3 text-color-Wsoft navBox-text">
				<h5>Clock Manager</h5>
			</router-link>
			<a class="mx-3 text-color-Wsoft navBox-text" @click="Deconnexion" href="#"> <h5>Deconnexion</h5> </a>
		</span>
	</div>
	<router-view />
</template>