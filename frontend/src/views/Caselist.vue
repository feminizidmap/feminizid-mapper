<template>
  <div class="codelists container-fluid">
    <div class="row my-2">
      <h1 class="display-4">{{ $t('layout.caselist') }}</h1>
    </div>
    <div class="row">
      Here goes the view
      <router-view></router-view>
    </div>
  </div>
</template>

<script>
 //import { sortBy } from 'lodash'

 export default {
   name: 'CaseList',
   created () {
     if (this.$store.state.signedIn) {
       this.populateCases()
     } else {
       this.$router.replace('/')
     }
   },
   methods: {
     populateCases() {
       this.$http.secured.get('/case')
           .then(response => {
             this.$store.commit('setCodelists', response.data)
           })
           .catch(error => { this.setError(error, 'Something went wrong') })
     },
     setError (error, text) {
       const e = (error.response && error.response.data && error.response.data.error) || text
       this.$store.commit('addAlert', { type: 'error', message: e})
     }
   }
 }
</script>
