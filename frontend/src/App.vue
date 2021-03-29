<template>
  <div class="d-flex flex-column h-100">
    <AppHeader></AppHeader>
    <div class="flex-shrink-0 pt-3 pb-5">
      <router-view/>
    </div>
    <AppFooter></AppFooter>
  </div>
</template>
<script>
 import AppHeader from '@/layout/AppHeader'
 import AppFooter from '@/layout/AppFooter'

 export default {
   components: { AppFooter, AppHeader }
 }
</script>
<style>
 #app {
   font-family: Avenir, Helvetica, Arial, sans-serif;
   -webkit-font-smoothing: antialiased;
   -moz-osx-font-smoothing: grayscale;
   color: #2c3e50;
   min-height: 100vh;
   height: 100vh;
 }

</style>
