<template>
  <nav class="navbar rounded">
    <ul class="navbar ml-auto">
      <li class="nav-item">
        <a class="nav-link" v-if="showAdminLink()">Admin</a>
      </li>
      <li class="nav-item sign-out">
        <Signout />
      </li>
    </ul>
  </nav>
</template>

<script>
 import Signout from '@/components/Signout.vue'

 export default {
   name: 'AppHeader',
   components: { Signout },
   methods: {
     setError (error, text) {
       this.error = (error.response && error.response.data && error.response.data.error) || text
     },
     showAdminLink () {
       return this.$store.getters.isAdmin || this.$store.getters.isReviewer
     }
   }
 }
</script>
