<script>

import axios from 'axios'

export default {
    data() {
        return {
            wTimes: []
        }
    },
    methods : {
        async getWorkingTimes(id, start, end) {
            const baseURI = 'http://localhost:4000/api/workingtimes/'+id+'?start='+ start +'&end='+ end
            await axios.get(baseURI)
            .then((result) => {
                this.wTimes = result.data
            })
        }
    }
}

</script>

<template>
    <div class="container text-color-Wsoft">
        <div class="black-soft rounded w-100 p-5 text-center">
            <h1>Où?</h1>
            <button @click="createUser('Test2', 't2est@gmail.com')" >Click me!</button>
        </div>
    </div>
    <div class="container text-color-Wsoft mt-5">
        <div class="black-soft rounded w-100 p-5 text-center">
            <h1>Météo actuelle à </h1>
            <div v-for="aWtime in wTimes" :key="aWtime.id">
                    <h1> {{ aWtime.start }}</h1>
                    <p> {{ aWtime.end }}</p>
                </div>
        </div>
    </div>
</template>