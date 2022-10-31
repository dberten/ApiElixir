<script>

import axios from 'axios'
import moment from 'moment/min/moment-with-locales'
import WorkingTime from './WorkingTime.vue'
moment.locale('fr')
import { useRoute } from 'vue-router';

export default {
    data() {
        return {
            users: [],
            wTimes: [],
        };
    },
    methods: {
        async getWorkingTimes(start, end) {
            const baseURI = "http://localhost:4000/api/workingtimes/" + useRoute().params.userId + "?start=" + start + "&end=" + end;
            await axios.get(baseURI)
                .then((result) => {
                this.wTimes = result.data;
            });
        },
        moment: function () {
            return moment();
        },
    },
    created() {
        let start = moment().subtract(7, "d").format("YYYY-MM-DD hh:mm:ss");
        let end = moment().format("YYYY-MM-DD hh:mm:ss");
        this.getWorkingTimes(start, end);
    },
    
    components: { WorkingTime }
}

</script>

<template>
    <div class="container text-color-Wsoft">
        <div class="black-soft rounded w-100 p-5 text-center">
            <h1>Mes Heures </h1>

            <div v-for="aWtime in wTimes" :key="aWtime.id">
                <h1> {{ aWtime.start }}</h1>
                <p> {{ aWtime.end }}</p>
                <router-link :to="{ name: 'Modifier', params: { userId: 1, workingtimeId: aWtime.id}}" >Mes Heures</router-link> |
            </div>
        </div>
    </div>
    
    <div class="container text-color-Wsoft mt-5">
        <div class="black-soft rounded w-100 p-5 text-center">
            <WorkingTime />
        </div>
    </div>
</template>