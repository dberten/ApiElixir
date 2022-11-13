import { createRouter, createWebHistory } from 'vue-router'
import WorkingTime from '../components/WorkingTime.vue'
import Clock from '../components/ClockManager.vue'
import RegisterUser from '../components/RegisterUser.vue'
import LoginUser from '../components/LoginUser.vue'
import NotFound from '../components/NotFound.vue'
import Home from '../components/WorkingTimes.vue'

    const routes = [
        {
            path: '/RegisterUser',
            name: 'RegisterUser',
            component: RegisterUser,
            meta:{
                guest:true
            }
        },
        {
            path: '/LoginUser',
            name: 'LoginUser',
            component: LoginUser,
            meta:{
                guest:true
            }
        },
        {
            path: '/',
            name: 'Home',
            component: Home,
            meta:{
                requiresAuth:true
            }
        },
        {
            path: '/WorkingTime',
            name: 'WorkingTime',
            component: WorkingTime,
            meta:{
                requiresAuth:true
            }
        },
        
        {
            path: '/Clock',
            name: 'Clock',
            component: Clock,
            meta:{
                requiresAuth:true
            }
        },
        { 
            path: '/:pathMatch(.)',
            name: 'NotFound', 
            component: NotFound,
            meta: {
                requiresAuth: true,
                guest: true
            }
        }
    ]
    const router = createRouter({
        history: createWebHistory(),
        routes
    })

    router.beforeEach((to, from, next) => {
        const sessionObject = JSON.parse(sessionStorage.getItem('sessionObject'));
        // If route has meta tag requiresAuth
        if (to.matched.some(record => record.meta.requiresAuth)) {
          // Check if token exist, if not exist -> go to login
          if (sessionObject == null) {
            next({
              path: '/LoginUser',
              params: {nextUrl: to.fullPath}
            })
          } 
          // Acces to the rest of routes 
          else {
            next()
          }
        } 
        else if (to.matched.some(record => record.meta.guest)) {
          // If no token, stay on login page
          if (sessionObject == null) {
            next()
          } 
          // Go to home
          else {
            next({name: 'Home'})
          }
        } 
        // If no meta 
        else {
          next()
        }
      })
      export default router