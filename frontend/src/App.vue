<template>
  <router-view/>
  <AppFooter></AppFooter>
</template>
<script>
 import AppFooter from '@/layout/AppFooter'

 export default {
   components: { AppFooter }
 }
</script>
<style>
 #app {
   font-family: Avenir, Helvetica, Arial, sans-serif;
   -webkit-font-smoothing: antialiased;
   -moz-osx-font-smoothing: grayscale;
   color: #2c3e50;
 }

</style>
