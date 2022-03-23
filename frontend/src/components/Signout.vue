<template>
  <div class="signout">
    <button @click="signOut" class="btn btn-link">Sign out</button>
  </div>
</template>

<script>
 export default {
   name: 'Signout',
   methods: {
     signOut () {
       this.$httpSecured.delete('/signin')
           .then(() => {
             this.$store.commit('addAlert', { type: 'notice', message: this.$t('notice.singedOut') })
             this.$store.commit('unsetCurrentUser')
             this.$router.replace('/signin')
           })
           .catch(error => this.setError(error, this.$t('errors.cannotSignout')))
     },
     setError (error, text) {
       const e = (error.response && error.response.data && error.response.data.error) || text
       this.$store.commit('addAlert', { type: 'error', message: e })
     }
   }
 }
</script>

<style lang="css">
</style>
