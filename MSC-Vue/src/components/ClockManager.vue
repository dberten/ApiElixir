<script>

import moment from 'moment/min/moment-with-locales'
moment.locale('fr')
import axios from 'axios'
import { useRoute } from 'vue-router';

export default {
    data(){
        /* regarder moment js pour la date*/
        return{
            wtId: useRoute().params.userId,
            cmId: null,
            user: [],
            state:false, // etat de la clock vrai-> en fonctionnement
            startDateTime:null, //debut du temps de travail (String)
            endDateTime:null,
            date1 : moment(''), //debut du temps de travail (Object)
            date2 : moment(''),
            duration : null
        }
    },
    methods: {
        async clockIn(){
            /* boolean : true -> work in progress */
            if(this.state){
                this.state = false
                const baseURI = 'http://localhost:4000/api/clocks/' + this.wtId
                //post date de debut
                await axios.post(baseURI,
                {
                    "clock":{
                        "status":true,
                        "time": this.startDateTime,
                        "user": this.wtId
                    }
                }).then (
                    console.log("date 1 submitted")
                )
                //post date de fin
                await axios.post(baseURI,
                {
                    "clock":{
                        "status": false,
                        "time": this.endDateTime,
                        "user": this.wtId
                    }
                }).then(
                    console.log("date 2 submited")
                )
            }
            else this.state = true


        },
        refresh(){
            /* refresh = mise a 0 */
            this.state = false,
            this.startDateTime = null,
            this.endDateTime = null,
            this.date1 = moment(''),
            this.date2 = moment('')            
        },
        clock(){
            console.log(this.state)
            /* pass to active to inactive */
            if(this.state){        
                //console.log(this.state)        
                this.startDateTime= moment().format('YYYY-MM-DD hh:mm:ss') // methode retourne un string
                this.date1=moment(this.startDateTime) // methode retourne objet
                this.endDateTime = null
                this.date2 = moment('')
            }
            else {
                //console.log(this.state)
                this.endDateTime = moment().format('YYYY-MM-DD hh:mm:ss')
                this.date2 = moment(this.endDateTime)
                this.duration = this.date1.diff(this.date2, 'hours')
                //console.log("heures travaillés : " + this.duration)
            }

        },
    },
    mounted(){
            /* utilisation de la route*/
            this.wtId = useRoute().params.userId
            //console.log(moment().format('YYYY-MM-DD hh:mm:ss'))
            //console.log(this.startDateTime)

            const baseURI = 'http://localhost:4000/api/clocks/' + this.wtId
            //console.log("ça manage")
            
            axios.get(baseURI).then((result)=>{
                if(result.status){
                    console.log("if axios")
                    result.date = this.startDateTime
                    this.date1 = moment(this.startDateTime)
                }
            })
            //console.log("end axios")
            
        }
}
</script>

<template>
    <div>
        <div class="container text-color-Wsoft black-soft rounded w-100 p-5 text-center">
            <!-- click sur Start demarre la clock-->
            <button class="btn btn-primary" @click="clockIn(),clock()">Start</button>
            <br>
            <br>
            <!-- refresh reset toutes les données actuelles-->
            <button class="btn btn-primary" @click="refresh()">Refresh</button>
        </div>
        <div class="fw-bold container text-color-Wsoft black-soft rounded w-100 p-5 text-center">
            <div v-if="startDateTime==null && endDateTime == null">
                <!--si aucune clock en route la page est vide-->
                <h2></h2>
                <h2></h2>
            </div>
            <div v-else-if="endDateTime == null">
                <!-- au premier click de bouton la date de debut est enregistrée-->
                <h2>Début : {{startDateTime}}</h2>
                <h2></h2>
                <h2>Work in progress...</h2>
            </div>
            <div v-else>
                <!--au dernier click affiche recap final-->
                <h2>Début : {{startDateTime}}</h2>
                <h2>Fin : {{endDateTime}}</h2>
                <!-- soustraction du temps final par le temps initial-->
                <h2>Durée du travail : {{this.duration}} heures</h2>
            </div>
        </div>

    </div>
</template>
