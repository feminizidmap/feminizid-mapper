<template>
  <nav class="navbar navbar-expand-lg">
    <div class="container-fluid">
      <a class="navbar-brand" href="#">Mapper</a>
      <button class="navbar-toggler"
              type="button" data-bs-toggle="collapse"
              data-bs-target="#navbarNav"
              aria-controls="navbarNav"
              aria-expanded="false"
              aria-label="Toggle navigation">
        <span class="fa fa-bars"></span>
      </button>

      <div class="collapse navbar-collapse" id="navbarNav">
        <ul class="navbar-nav">
          <li class="nav-item">
            <a class="nav-link" v-if="showAdminLink()">Admin</a>
          </li>
          <li class="nav-item sign-out">
            <Signout />
          </li>
        </ul>
      </div>
    </div>
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
