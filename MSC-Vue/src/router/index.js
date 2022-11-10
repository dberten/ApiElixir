import { createRouter, createWebHistory } from 'vue-router'

export default createRouter({
    history: createWebHistory(),
    routes: [
        {
            path: '/currentWeather/:valCity',
            name: 'Current Weather',
            component: () => import('../components/CurrentWeather.vue')
        },
        {
            path: '/workingTimes/',
            name: 'Mes Heures',
            
            component: () => import('../components/WorkingTimes.vue')
        },
        {
            path: '/workingTime/',
            name: 'Créer',
            props: true,

            component: () => import('../components/WorkingTime.vue')
        },
        // {
        //     path: '/workingTime/:userId/:workingtimeId',
        //     name: 'Modifier',
            
        //     component: () => import('../components/WorkingTime.vue')
        // },
        {
            path: '/user',
            name: 'User',
            component: () => import('../components/User.vue')
        },
        // {
        //     path: '/ClockManager/:userId',
        //     name: 'ClockManager',
        //     component: () => import('../components/ClockManager.vue')
        // },
    ]
})