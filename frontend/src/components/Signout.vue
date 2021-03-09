<template>
  <div class="signout">
    <button @click="signOut">Sign out</button>
  </div>
</template>

<script>
 export default {
   name: 'Signout',
   data () {
   },
   methods: {
     signOut () {
       this.$http.secured.delete('/signin')
           .then(() => {
             delete localStorage.csrf
             delete localStorage.signedIn
             this.$router.replace('/')
           })
           .catch(error => this.setError(error, 'Cannot sign out'))
     }
   }
 }
</script>

<style lang="css">
</style>
