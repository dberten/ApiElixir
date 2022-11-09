<script>

import axios from 'axios'
import moment from 'moment/min/moment-with-locales'

import WorkingTime from './WorkingTime.vue'
import ClockManager from './ClockManager.vue'
moment.locale('fr')
import { useRoute } from 'vue-router';

import { Calendar, DatePicker } from 'v-calendar';
import "v-calendar/dist/style.css"

export default {
	props: {
		wtId: null
	},
	data() {
		return {
			users: [],
			calTimes: [],
			wTimes: [],
			userIdC: null,
			modalUpdate: [],
			timezone: '',
			isFirstClick: false,
		};
	},
	methods: {
		async getWorkingTimes(start, end) {
			const baseURI = "http://localhost:4000/api/workingtimes/" + this.userIdC + "?start=" + start + "&end=" + end;
			await axios.get(baseURI)
				.then((result) => {
					this.wTimes = result.data;
				});
		},
		async updateWorkingTime() {
			const baseURI = 'http://localhost:4000/api/workingtimes/' + this.modalUpdate.id
			await axios.put(baseURI,
				{
					"workingtime": {
						"start": this.modalUpdate.start,
						"end": this.modalUpdate.end
					}
				}).then((result) => {
					// DISP SUCCESS RESPONSE
				});
		},
		async deleteWorkingTime() {
            const baseURI = 'http://localhost:4000/api/workingtimes/' + this.modalUpdate.id
            await axios.delete(baseURI)
        },
		moment: function () {
			return moment();
		},
		moment(varr) {
			return moment(varr);
		},
		refreshData() {
			let start = moment().subtract(7, "d").format("YYYY-MM-DD hh:mm:ss");
			let end = moment().format("YYYY-MM-DD hh:mm:ss");
			
			this.getWorkingTimes(start, end);
		},
		getHoursDiff(startDate, endDate) {
			var startTime = moment(startDate);
			var endTime = moment(endDate);

			// calculate total duration
			var duration = moment.duration(endTime.diff(startTime));

			// duration in hours
			var hours = parseInt(duration.asHours());

			// duration in minutes
			var minutes = parseInt(duration.asMinutes()) % 60;

			return hours + 'h ' + minutes + 'min';

		},
		calendarRefreshData() {
			if (this.isFirstClick) { // TRUE
				this.isFirstClick = false
				if (this.calTimes.length != 0) {
					let start = moment(this.calTimes.start).format("YYYY-MM-DD hh:mm:ss");
					let end = moment(this.calTimes.end).format("YYYY-MM-DD hh:mm:ss");

					this.getWorkingTimes(start, end)
				}
			} else { // FALSE
				this.isFirstClick = true
			}
		}
	},
	mounted() {
		this.userIdC = useRoute().params.userId;

		this.refreshData();


		console.log(this.userIdC);
	},

	components: { WorkingTime, ClockManager, Calendar, DatePicker }
}

</script>

<template>

	<div class="container p-0 mt-5">
		<ClockManager :userId="this.userIdC" />

	</div>

	<div class="container borderModal-linear p-0 py-5 my-5" id="owBorder-linear">
		<div class="d-sm-flex justify-content-between align-items-center">
			<DatePicker class="calendar" :value="null" color="green" is-dark is-range v-model="calTimes" @click="calendarRefreshData()"/>

			<div class="">.col-md-4</div>
		</div>
	</div>

	<div v-for="aWtime in wTimes" :key="aWtime.id">
		<div class="container p-0 mb-5 text-color-Wsoft d-md-flex align-items-center wt-backBox black-soft rounded">
			<div class="p-2 pt-3 flex-shrink-0 wt-dayBox fw-bold text-capitalize"> {{ moment(aWtime.start).format("Do") }} <br /> {{ moment(aWtime.start).format("MMMM").substring(0, 3) }}</div>

			<div class="ms-md-3 wt-dataBox">
				<h2 class="d-sm-flex mx-5 justify-content-between"> <span>Début</span> {{ aWtime.start }}</h2>
				<h2 class="d-sm-flex mx-5 justify-content-between"> <span>Fin</span> {{ aWtime.end }}</h2>
				<h2 class="d-sm-flex mx-5 justify-content-between"> <span>Heures travaillées</span> 
					{{ this.getHoursDiff(aWtime.start, aWtime.end) }}
				</h2>
				<span class="d-flex mx-5 justify-content-end">
					<a href="#" data-bs-target="#ModalModifier"
						v-on:click="modalUpdate.start = aWtime.start; modalUpdate.end = aWtime.end; modalUpdate.id = aWtime.id"
						data-bs-toggle="modal"> Modifier </a>
					<a href="#" data-bs-target="#ModalSupprimer"
						v-on:click="modalUpdate.id = aWtime.id"
						data-bs-toggle="modal"> Supprimer </a>
					<!-- <router-link :to="{ name: 'Modifier', params: { userId: 1, workingtimeId: aWtime.id } }">Modifier
                    </router-link> -->
				</span>
			</div>
		</div>
	</div>

	<div class="container p-0 text-color-Wsoft mb-5">
		<div class="black-soft rounded w-100 p-5 text-center">
			<WorkingTime :userId="this.userIdC" />


			<div class="modal fade" id="ModalModifier" aria-hidden="true" aria-labelledby="ModalModifierLabel"
				tabindex="-1">
				<div class="modal-dialog modal-lg modal-dialog-centered">
					<div class="modal-content black borderModal-linear borderTop-linear">
						<div class="modal-header">
							<h1 class="modal-title fs-5" id="ModalModifierLabel">Modification du WorkingTime</h1>
							<button type="button" class="btn-close text-color-Wsoft" data-bs-dismiss="modal" aria-label="Close"></button>
						</div>
						<div class="modal-body">

							<div class="container-fluid">
								<div class="row mb-4">
									<div class="col-md-4">
										<h3>Début</h3>
									</div>
									<div class="col-md-4">
										<DatePicker v-model="modalUpdate.start" class="calendar" color="green" is-dark
											mode="dateTime" :timezone="timezone" />
									</div>
								</div>
								<div class="row">
									<div class="col-md-4">
										<h3>Fin</h3>
									</div>
									<div class="col-md-4">
										<DatePicker v-model="modalUpdate.end" class="calendar" color="green" is-dark
											mode="dateTime" :timezone="timezone" />
									</div>
								</div>
							</div>
						</div>
						<div class="modal-footer">
							<button @click="updateWorkingTime" data-bs-dismiss="modal" class="btn btn-success">Valider</button>

							<button type="button" class="btn btn-secondary" data-bs-dismiss="modal" aria-label="">Fermer</button>

						</div>
					</div>
				</div>
			</div>



			<div class="modal fade" id="ModalSupprimer" aria-hidden="true" aria-labelledby="ModalSupprimerLabel"
				tabindex="-1">
				<div class="modal-dialog modal-lg modal-dialog-centered">
					<div class="modal-content black borderModal-linear borderTop-linear">
						<div class="modal-header">
							<h1 class="modal-title fs-5" id="ModalSupprimerLabel">Voulez-vous vraiment supprimer ce Worktime?</h1>
							<button type="button" class="btn-close text-color-Wsoft" data-bs-dismiss="modal" aria-label="Close"></button>
						</div>
						
						<div class="modal-footer">
							<button @click="deleteWorkingTime" data-bs-dismiss="modal" class="btn btn-danger">Valider</button>

							<button type="button" class="btn btn-secondary" data-bs-dismiss="modal" aria-label="">Fermer</button>

						</div>
					</div>
				</div>
			</div>



		</div>

	</div>
</template>