<template>
  <header>
    <AppNav></AppNav>
    <AppAlerts></AppAlerts>
  </header>
</template>

<script>
 import AppNav from '@/layout/AppNav.vue'
 import AppAlerts from '@/layout/AppAlerts.vue'

 export default {
   name: 'AppHeader',
   components: { AppNav, AppAlerts },
   methods: {

   }
 }
</script>
