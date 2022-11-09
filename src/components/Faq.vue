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
                a:'Le service ne dispose actuellement pas ',
                open: false
            },
            {
                q:'Quel but à l\'application ',
                a:'',
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