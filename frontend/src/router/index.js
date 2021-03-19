import { createRouter, createWebHistory } from 'vue-router'
import Signin from '@/views/Signin'
import Signup from '@/views/Signup'
import ForgotPassword from '@/views/ForgotPassword'
import ResetPassword from '@/views/ResetPassword'

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
    path: '/forgot_password',
    name: 'ForgotPassword',
    component: ForgotPassword
  },
  {
    path: '/password_resets/:token',
    name: 'ResetPassword',
    component: ResetPassword
  },
  {
    path: '/dashboard',
    name: 'Dashboard',
    component: () => import(/* webpackChunkName: "dashboard" */ '@/views/Dashboard.vue')
  },
  {
    path: '/settings/codelists',
    name: 'Codelists',
    component: () => import(/* webpackChunkName: "codelists" */ '@/views/admin/codelists/List.vue')
  },
  {
    path: '/admin/users',
    name: 'AdminUsersList',
    component: () => import(/* webpackChunkName: "userslist" */ '@/views/admin/users/List.vue')
  },
  {
    path: '/admin/users/:id',
    name: 'UserEdit',
    component: () => import(/* webpackChunkName: "usersedit" */ '@/views/admin/users/Edit.vue')
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
