<template>
  <div class="users">
    <div class="alert alert-danger" v-if="error">{{ error }}</div>
    <h3>Users</h3>

    <table class="table">
      <thead>
        <tr>
          <th>ID</th>
          <th>Email</th>
          <th>Role</th>
          <th v-if="showChangesLink()">Changes</th>
        </tr>
      </thead>
      <tbody>
        <tr v-for="user in users" :key="user.id" :user="user">
          <th>{{ user.id }}</th>
          <td td v-if="showUsersLink(user)">
            <router-link :to="`/admin/users/${user.id}`">
              {{ user.email }}
            </router-link>
          </td>
          <td td v-else>
            {{ user.email }}
          </td>
          <td>{{ user.role }}</td>
          <td v-if="showChangesLink()">
            <router-link :to="`/admin/users/${user.id}/changes`">
              <i class="fa fa-list-ul"></i>
            </router-link>
          </td>
        </tr>
      </tbody>
    </table>
  </div>
</template>

<script>
 export default {
   name: 'UsersList',
   components: {},
   data () {
     return {
       error: '',
       users: []
     }
   },
   created () {
     if (this.$store.state.signedIn && (this.$store.getters.isAdmin || this.$store.getters.isReviewer)) {
       this.$httpSecured.get('/admin/users')
           .then(response => { this.users = response.data })
           .catch(error => { this.setError(error, 'Something went wrong') })
     } else {
       this.$router.replace('/')
     }
   },
   methods: {
     setError (error, text) {
       this.error = (error.response && error.response.data && error.response.data.error) || text
     },
     showChangesLink () {
       return this.$store.getters.isAdmin
     },
     showUsersLink (user) {
       return this.$store.getters.isAdmin && this.$store.getters.currentUserId !== user.id
     }
   }
 }
</script>
