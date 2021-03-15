import { createRouter, createWebHistory } from 'vue-router'
import Signin from '@/views/Signin'
import Signup from '@/views/Signup'
//import Dashboard from '@/views/Dashboard'

const routes = [
  {
    path: '/',
    name: 'Signin',
    component: Signin
  },
  {
    path: '/signup',
    name: 'Signup',
    component: Signup
  },
  {
    path: '/dashboard',
    name: 'Dashboard',
    component: () => import(/* webpackChunkName: "dashboard" */ '@/views/Dashboard.vue')
  },
  {
    path: '/admin/users',
    name: 'AdminUsersList',
    component: () => import(/* webpackChunkName: "userslist" */ '@/views/admin/users/List.vue')
  },
  {
    path: '/admin/users/:id/changes',
    name: 'AdminUsersChangesList',
    component: () => import(/* webpackChunkName: "userschangeslist" */ '@/views/admin/users/changes/List.vue')
  }

]

const router = createRouter({
  history: createWebHistory(process.env.BASE_URL),
  routes
})

export default router
