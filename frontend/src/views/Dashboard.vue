<template>
  <div class="dashboard">
    <h1>Dashboard</h1>
    <Signout />
    <ChangesList />
  </div>
</template>

<script>
 import Signout from '@/components/Signout'
 import ChangesList from '@/components/changes/List'

 export default {
   name: 'Dashboard',
   components: { ChangesList, Signout },
   data () {
     return {

     }
   },
   created () {
     if (!localStorage.signedIn) {
       this.$router.replace('/')
     }
   },
   methods: {
   }
 }
</script>

<style lang="css">
 .todos ul li i.fa.fa-trash-alt {
   visibility: hidden;
   margin-top: 5px;
 }
 .todos ul li:hover {
   background: #fcfcfc;
 }
 .todos ul li:hover i.fa.fa-trash-alt {
   visibility: visible;
 }
</style>
