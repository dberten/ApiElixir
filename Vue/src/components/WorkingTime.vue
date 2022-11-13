<script>

import axios from 'axios'
import { useRoute } from 'vue-router';

export default {
    data() {
        return {
            wTimes: [],
            formCreate: {
                userId: 1,
                start: "2022-10-23 02:09:05",
                end: "2022-10-23 02:09:05"
            },
            submitted: false
        }
    },
    methods: {

        createWorkingTime() {
            const baseURI = 'http://localhost:4000/api/workingtimes/' + localStorage.getItem('s_userId')
            axios.post(baseURI,
                {
                    "workingtime": {
                        "start": this.formCreate.start,
                        "end": this.formCreate.end
                    }
                }).then(
                    this.submitted = true
                )
        },
        async updateWorkingTime(idW, start, end) {
            const baseURI = 'http://localhost:4000/api/workingtimes/' + idW
            await axios.put(baseURI,
                {
                    "workingtimes": {
                        "start": start,
                        "end": end
                    }
                })
        },
        async deleteWorkingTime(idW) {
            const baseURI = 'http://localhost:4000/api/workingtimes/' + idW
            await axios.delete(baseURI)
        },
        newForm() {
            this.submitted = false;
            this.formCreate = {};
        }
    },
    mounted() {

    }
}

</script>
 
<template>
    <div v-if="!submitted">
        <p>
            <label for="start">start</label>
            <input id="start" v-model="formCreate.start" type="text" name="start">
        </p>
        <p>
            <label for="end">end</label>
            <input id="end" v-model="formCreate.end" type="text" name="end">
        </p>
        <button @click="createWorkingTime" class="btn btn-success">Submit</button>
    </div>

    <div v-else>
        <h4>You submitted successfully!</h4>
        <button class="btn btn-success" @click="newForm">Add Another</button>
    </div>
</template>