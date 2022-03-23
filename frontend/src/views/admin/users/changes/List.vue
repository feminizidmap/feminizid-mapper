<template>
  <div class="users">
    <div class="alert alert-danger" v-if="error">{{ error }}</div>
    <h3>User changes</h3>
    <table class="table">
      <thead>
        <tr>
          <th>ID</th>
          <th>User ID</th>
          <th>Title</th>
        </tr>
      </thead>
      <tbody v-if="changes.length">
        <tr v-for="change in changes" :key="change.id" :change="change">
          <th>{{ change.id }}</th>
          <th>{{ change.user_id }}</th>
          <td>{{ change.status }}</td>
        </tr>
      </tbody>
      <div v-else>None</div>
    </table>
  </div>
</template>

<script>
 export default {
   name: 'UserChangesList',
   components: {},
   data () {
     return {
       error: '',
       changes: []
     }
   },
   created () {
     if (this.$store.state.signedIn && this.$store.getters.isAdmin) {
       this.$httpSecured.get(`/admin/users/${this.$route.params.id}/changes`)
           .then(response => {
             this.changes = response.data
           })
           .catch(error => { this.setError(error, 'Something went wrong') })
     } else {
       this.$router.replace('/')
     }
   },
   methods: {
     setError (error, text) {
       this.error = (error.response && error.response.data && error.response.data.error) || text
     }
   }
 }
</script>
