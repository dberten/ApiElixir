<script>

import axios from 'axios'
import moment from 'moment/min/moment-with-locales'
import WorkingTime from './WorkingTime.vue'
import ClockManager from './ClockManager.vue'
moment.locale('fr')
import { useRoute } from 'vue-router';

export default {
    props: {
        wtId: null
    },
    data() {
        return {
            users: [],
            wTimes: [],
            userIdC: null
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
        moment: function () {
            return moment();
        },
    },
    mounted() {
        let start = moment().subtract(7, "d").format("YYYY-MM-DD hh:mm:ss");
        let end = moment().format("YYYY-MM-DD hh:mm:ss");
        this.userIdC = useRoute().params.userId

        this.getWorkingTimes(start, end);

        console.log(this.userIdC);

        

    },

    components: { WorkingTime, ClockManager }
}

</script>

<template>
    <div v-for="aWtime in wTimes" :key="aWtime.id">
        <div class="container p-0 text-color-Wsoft d-md-flex align-items-center wt-backBox black-soft rounded">
            <div class="p-2 pt-3 flex-shrink-0 wt-dayBox fw-bold">22 <br/> Jan</div>

            <div class="ms-md-3 wt-dataBox">
                <h2 class="d-sm-flex mx-5 justify-content-between"> <span>Début</span> {{ aWtime.start }}</h2>
                <h2 class="d-sm-flex mx-5 justify-content-between"> <span>Fin</span> {{ aWtime.end }}</h2>
                <h2 class="d-sm-flex mx-5 justify-content-between"> <span>Heures travaillées</span> {{ aWtime.id }}</h2>
                <span class="d-flex mx-5 justify-content-end">
                    <router-link :to="{ name: 'Modifier', params: { userId: 1, workingtimeId: aWtime.id } }">Modifier
                    </router-link>
                </span>
            </div>
        </div>
    </div>

    <div class="container p-0 text-color-Wsoft mt-5">
        <div class="black-soft rounded w-100 p-5 text-center">
            <WorkingTime :userId="this.userIdC" />
            <ClockManager :userId="this.userIdC" />

            <br/>

<div class="modal fade" id="exampleModalToggle" aria-hidden="true" aria-labelledby="exampleModalToggleLabel" tabindex="-1">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content">
      <div class="modal-header">
        <h1 class="modal-title fs-5" id="exampleModalToggleLabel">Modal 1</h1>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        Show a second modal and hide this one with the button below.
      </div>
      <div class="modal-footer">
        <button class="btn btn-primary" data-bs-target="#exampleModalToggle2" data-bs-toggle="modal">Open second modal</button>
      </div>
    </div>
  </div>
</div>
<div class="modal fade" id="exampleModalToggle2" aria-hidden="true" aria-labelledby="exampleModalToggleLabel2" tabindex="-1">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content">
      <div class="modal-header">
        <h1 class="modal-title fs-5" id="exampleModalToggleLabel2">Modal 2</h1>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        Hide this modal and show the first with the button below.
      </div>
      <div class="modal-footer">
        <button class="btn btn-primary" data-bs-target="#exampleModalToggle" data-bs-toggle="modal">Back to first</button>
      </div>
    </div>
  </div>
</div>
<a class="btn btn-primary" data-bs-toggle="modal" href="#exampleModalToggle" role="button">Open first modal</a>
        </div>
    </div>
</template>