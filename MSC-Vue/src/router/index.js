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
            path: '/user',
            name: 'User',
            component: () => import('../components/User.vue')
        },
    ]
})