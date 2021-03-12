<template>
  <div class="dashboard">
    <AppHeader></AppHeader>
    <div class="container-fluid mt-4">
      <div class="row">
        <h1>Dashboard</h1>
      </div>
    </div>
    <div class="container-fluid mt-4">
      <div class="row">
        <div class="col-sm-4">
          <ChangesList />
        </div>
      </div>
    </div>
  </div>
</template>

<script>
 import AppHeader from '@/layout/AppHeader'
 import ChangesList from '@/components/changes/List'

 export default {
   name: 'Dashboard',
   components: { ChangesList, AppHeader },
   data () {
     return {

     }
   },
   created () {
     if (!this.$store.state.signedIn) {
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
