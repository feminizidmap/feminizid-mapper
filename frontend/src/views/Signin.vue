<template>
  <div class="container-fluid mt-5">
    <div class="row justify-content-center">
      <form class="form-signin col-sm-3" @submit.prevent="signin">
        <div class="alert alert-danger" v-if="error">{{ error }}</div>
        <div class="form-group mb-4">
          <label for="email" class="form-label">{{ $t('forms.email') }}</label>
          <input v-model="email" type="email" class="form-control" id="email" placeholder="email@example.com">
        </div>
        <div class="form-group mb-4">
          <label for="password" class="form-label">{{ $t('forms.password') }}</label>
          <input v-model="password" type="password" class="form-control" id="password" placeholder="Password">
        </div>
        <button type="submit" class="btn btn-primary mb-3">{{ $t('forms.signIn') }}</button>
        <div>
          <router-link to="/signup">{{ $t('forms.signUp') }}</router-link>
          <br />
          <router-link to="/forgot_password">{{ $t('forms.forgotPassword') }}</router-link>
        </div>
      </form>
    </div>
  </div>
</template>

<script>
 export default {
   name: 'Signin',
   data () {
     return {
       email: '',
       password: '',
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
     signin () {
       this.$http.plain.post('/signin', { email: this.email, password: this.password })
           .then(response => this.signinSuccessful(response))
           .catch(error => this.signinFailed(error))
     },
     signinSuccessful (response) {
       if (!response.data.csrf) {
         this.signinFailed(response)
         return
       }
       this.$http.plain.get('/me')
           .then(meResponse => {
             this.$store.commit('setCurrentUser', { currentUser: meResponse.data,
                                                    csrf: response.data.csrf })
             this.error = ''
             this.$router.replace('/dashboard')
           })
           .catch(error => this.signinFailed(error))
     },
     signinFailed (error) {
       this.error = (error.response && error.response.data && error.response.data.error) || ''
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
