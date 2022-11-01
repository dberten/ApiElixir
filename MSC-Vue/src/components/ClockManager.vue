<script>

import moment from 'moment/min/moment-with-locales'
moment.locale('fr')

export default {
    data(){
        /* regarder moment js pour la date*/
        return{
            cmId:null,
            user: [],
            state:false, // etat de la clock vrai-> en fonctionnement
            startDateTime:null, //debut du temps de travail (String)
            endDateTime:null,
            date1 : moment(''), //debut du temps de travail (Object)
            date2 : moment(''),
            drtn : ''
        }
    },
    methods: {
        clockIn(){
            /* boolean : true -> work in progress */
            if(this.state){
                this.state = false
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
            /* pass to active to inactive */
            if(!this.state){
                this.startDateTime= moment().format('YYYY-MM-DD hh:mm:ss') // methode retourne un string
                this.date1=moment(this.startDateTime) // methode retourne objet
                this.endDateTime = null
                this.date2 = moment('')
            }
            else {
                this.endDateTime = moment().format('YYYY-MM-DD hh:mm:ss')
                this.date2 = moment(this.endDateTime)
                this.drtn = moment.duration(this.startDateTime, 'milliseconds')

                /* Faire le post vers l'api ici */
            }

        },
        mounted(){
            /* utilisation de la route*/
            wtId = useRoute().params.userId
            console.log(moment.format('YYYY-MM-DD hh:mm:ss'))
            console.log(startDateTime)
        }

    }
}
</script>

<template>
    <div>
        <!-- click sur Start demarre la clock-->
        <button @click="clock(), clockIn()">Start</button>
        <br>
        <!-- refresh reset toutes les données actuelles-->
        <button @click="refresh()">Refresh</button>
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
            <h2>Durée du travail : {{date1.diff(date2, 'hours')}} heures</h2>
        </div>
    </div>
</template>
