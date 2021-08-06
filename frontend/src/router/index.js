import { createRouter, createWebHistory } from 'vue-router'

import Signin from '@/views/Signin'
import Signup from '@/views/Signup'
import ForgotPassword from '@/views/ForgotPassword'
import ResetPassword from '@/views/ResetPassword'

import cases from './case'
import admin from './admin'

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
  cases,
  admin
]

const router = createRouter({
  history: createWebHistory(process.env.BASE_URL),
  routes
})

export default router
