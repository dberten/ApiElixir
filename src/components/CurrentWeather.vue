<script>
import moment from 'moment/min/moment-with-locales'
import { onMounted } from 'vue';
import { useRoute } from 'vue-router';

moment.locale('fr')

/*
function updateVille(val) { console.log(val); }

const villes= [
        { text: 'One', value: 'A' },
        { text: 'Two', value: 'B' },
        { text: 'Three', value: 'C' }
    ];*/


export default {
  props : { /*
    town: {
        type: String,
        required: true
    },
    temperature: {
        type: String,
        required: true
    } */
  },
  data() {
    return {
      city: "Tournai",
      temperature : 10,
      listCity : ["Tournai", "Lille", "Leuze", "Ath", "Lyon"],
      selected: "Tournai"
    }
  },
  methods : {
    refreshCurrentWeather () {
        this.temperature = (Math.random()*40).toFixed(0);
        this.city = this.selected;
    //   route.params.city = this.city;
    },
    moment: function () {
        return moment();
    }
  },
  mounted() {
    this.selected = useRoute().params.valCity;
    this.refreshCurrentWeather();

  }
  
}

</script>

<template>
    <div class="container text-color-Wsoft">
        <div class="black-soft rounded w-100 p-5 text-center">
            <h1>Où?</h1>
                <h3>
                    <select class="w-100" v-model="selected">
                        <option disabled>Sélectionner une ville</option>
                        <option v-for="city in listCity" :value="city">
                            {{ city }}
                        </option>
                    </select>
                </h3>
                <h3>
                    <router-link @click="refreshCurrentWeather()" v-bind:to="selected" > VALIDER </router-link>
                </h3>
        </div>
    </div>
    <div class="container text-color-Wsoft mt-5">
        <div class="black-soft rounded w-100 p-5 text-center">
            <h1>Météo actuelle à {{ city }}</h1>
            <h3>
                Temperature : {{ temperature }}
            </h3>
            <h3>
                Date : {{ moment().format('dddd MMMM YYYY') }}
            </h3>
        </div>
    </div>
</template>