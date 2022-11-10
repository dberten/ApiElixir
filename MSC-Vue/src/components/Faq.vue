<script>
import { ref } from 'vue'

export default {
    setup() {
        const faqBase = ref([
            {
                q: 'Est-ce que l\'application est sécurisée ? ',
                a: 'L\'échange de donnée ainsi que la connexion sont sécurisés via clé de cryptage.',
                open: false
            },
            {
                q: 'Est-ce adaptés a tous les usagés',
                a: 'Nous essayons de fair en sorte que le plus grand nombre puisse en beneficier.',
                open: false
            },
            {
                q:'Comment utiliser l\'application ?',
                a:'Inscrivez-vous et vous n\'aurez qu\' à pointer au debut et a la fin de votre temps de travail.',
                open: false
            },
            {
                q:'Comment est améliorée l\'application ?',
                a:'Elle est améliorée de façon constante sans porter défaut a votre expérience utilisateur',
                open: false
            },
            {
                q:'Annalysez vous les donnés ?',
                a:'Les seuls échanges de données sont les dates de debut et de fin d\'activitée ainsi que les informations d\'identification',
                open: false
            },
            {
                q:'Comment gerez vous les heures supplementaires ?',
                a:'Le service ne dispose actuellement pas d\'outils gerant les heures supplémentaires',
                open: false
            },
            {
                q:'Quel but à l\'application ',
                a:'Le but est d\'avoir un chronometre fidèle au temps de travail effectué',
                open: false
            },
            {
                q:'je dois quitter le travail durant une petite periode comment mettre sur pause ?',
                a:'Vous pouvez appuyer sur le bouton stop et reprendre via le bouton start',
                open: false
            },
            {
                q:'Puis-je voir les heures travaillés de mes collegues ?',
                a:'Non les heures travaillées sont privée au niveau logiciel, libre a vous de les partager a l\'oral',
                open: false
            },
            {
                q:'Si j\'oublie d\'éteindre mon chrono, puis-je le modifier ?',
                a:'Il est actuellement pas possible de le modifier... En revanche nous travaillons sur cette fonctionnalitée et devrais être disponible sous peu',
                open: false
            },
            {
                q:'Je ne travaille pas sur oridinateur comment gerer mes heures ?',
                a:'L\'application est disponible en version web mobile, la version application arrivera sous peu',
                open: false
            },
            {
                q:'L\'aplication est-elle disponible pour les personnes mal-voyante ?',
                a:'Nous travaillons actuellement a la rendre accesssible au plus grand monde',
                open: false
            },
            {
                q:'Comment sont payés les heures supplmentaires ?',
                a:'Votre organisme déduira en fonction de l\'heure de début et de fin le nombre d\'heures supplémentaires effectuées et vous paiera en consequence ',
                open: false
            },
        ])
        const closeAllFaq = (item) => {
            if(!item.open){
                faqBase.value.forEach(el => el.open = false)
            }
            item.open = !item.open;
        }
        return{faqBase, closeAllFaq}
    },
}
</script>

<template>
    <div class="faq_wrapper">
        <h1>
            Questions souvent posées
        </h1>
        <div class="faq_field_wrapper" v-for="(faq, i) in faqBase" :key="i">
            <div class="faq_field">
                <div class="open_faq" @click="closeAllFaq(faq)">
                    <h3>
                        {{ faq.q }}
                        <i class="fa-solid fa-plus" :class="faq.open ? 'rotate' : ''">
                        </i>
                    </h3>
                    <p class="invisible" :class="faq.open ? 'visible' : ''">
                        {{ faq.a }}
                    </p>
                </div>
            </div>
        </div>
    </div>
</template>

<style scoped>
.faq_wrapper{
    text-align: center;
    max-width: 500px;
    margin: 40px auto;
}
.faq_field{
    border: 1px solid green;
    border-radius: 10px;
    margin: 10px 0;
}

.faq_field_wrapper{
    margin-top: 20px;

}

.invisible{
    visibility: hidden;
    opacity: 0;
    height: 0;
    transition: opacity 0.3s, height 0.3s, padding 0.3s, visibility 0.3s;
}

.visible{
    visibility: visible;
    height: 70px;
    opacity: 1;
    padding: 10px 20 px;
}

h3{
    display: flex;
    align-items: center;
    justify-content: space-around;
    padding: 18px 24px;
    margin: 8px 0;

}

.open_faq{
    cursor: pointer;
}

.rotate{
    transform: rotate(45deg);
}

.fa-plus{
    transition: transform 0.3s;
}
</style>