<template>
  <div class="signout">
    <div class="alert alert-danger" v-if="error">{{ error }}</div>
    <button @click="signOut" class="btn btn-link">Sign out</button>
  </div>
</template>

<script>
 export default {
   name: 'Signout',
   data () {
     return {
       error: ''
     }
   },
   created() {
     this.error = ''
   },
   methods: {
     signOut () {
       this.$http.secured.delete('/signin')
           .then(() => {
             this.$store.commit('unsetCurrentUser')
             this.$router.replace('/')
           })
           .catch(error => this.setError(error, 'Cannot sign out'))
     },
     setError (error, text) {
       this.error = (error.response && error.response.data && error.response.data.error) || text
     }
   }
 }
</script>

<style lang="css">
</style>
