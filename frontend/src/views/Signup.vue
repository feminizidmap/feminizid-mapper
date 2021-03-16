<template>
  <div class="container-fluid mt-5">
    <div class="alert alert-danger" v-if="error">{{ error }}</div>
    <div class="row justify-content-center">
      <form class="form-signup col-sm-3" @submit.prevent="signup">
        <div class="form-group mb-4">
          <label for="email" class="form-label">Email address</label>
          <input v-model="email" type="email" class="form-control" id="email" placeholder="email@example.com">
        </div>
        <div class="form-group mb-4">
          <label for="password" class="form-label">Password</label>
          <input v-model="password" type="password" class="form-control" id="password" placeholder="Password">
        </div>
        <div class="form-group mb-4">
          <label for="password" class="form-label">Password Confirmation</label>
          <input v-model="password_confirmation" type="password" class="form-control" id="password_confirmation" placeholder="Password Confirmation">
        </div>
        <button type="submit" class="btn btn-primary mb-3">Sign up</button>
        <div>
          <router-link to="/">Sign in</router-link>
          <br />
          <router-link to="/forgot_password">Forgot Password</router-link>
        </div>
      </form>
    </div>
  </div>
</template>

<script>
 export default {
   name: 'Signup',
   data () {
     return {
       email: '',
       password: '',
       password_confirmation: '',
       error: ''
     }
   },
   created () {
     this.checkSignedIn()
   },
   updated () {
     this.checkSignedIn()
   },
   methods: {
     signup () {
       this.$http.plain.post('/signup', { email: this.email,
                                          password: this.password,
                                          password_confirmation: this.password_confirmation })
           .then(response => this.signupSuccessful(response))
           .catch(error => this.signupFailed(error))
     },
     signupSuccessful (response) {
       if (!response.data.csrf) {
         this.signupFailed(response)
         return
       }
       this.$http.plain.get('/me')
           .then(meResponse => {
             this.$store.commit('setCurrentUser', { currentUser: meResponse.data,
                                                    csrf: response.data.csrf })
             this.error = ''
             this.$router.replace('/dashboard')
           })
           .catch(error => this.signupFailed(error))
     },
     signupFailed (error) {
       this.error = (error.response && error.response.data && error.response.data.error) || 'Something went wrong'
       this.$store.commit('unsetCurrentUser')
     },
     checkSignedIn () {
       if (this.$store.state.signedIn) {
         this.$router.replace('/dashboard')
       }
     }
   }
 }
</script>

<style lang="css">
</style>
