<template>
  <div class="container-fluid mt-5">
    <div class="row justify-content-center">
      <form class="form-signup col-md-4 col-lg-3  text-center" @submit.prevent="signup">
        <h2 class="mb-4">{{ $t('prompts.signup') }}</h2>
        <div class="form-floating mb-1">
          <input v-model="email" type="email" class="form-control" id="email" placeholder="email@example.com">
          <label for="email" class="form-label">{{ $t('forms.email') }}</label>
        </div>
        <div class="form-floating mb-1">
          <input v-model="password" type="password" class="form-control" id="password" placeholder="Password">
          <label for="password" class="form-label">{{ $t('forms.password') }}</label>
        </div>
        <div class="form-floating mb-4">
          <input v-model="password_confirmation" type="password" class="form-control" id="password_confirmation" placeholder="Password Confirmation">
          <label for="password" class="form-label">{{ $t('forms.passwordConfirmation') }}</label>
        </div>
        <button type="submit" class="btn btn-lg btn-primary w-100 mb-4">{{ $t('forms.signUp') }}</button>
        <div>
          <router-link to="/">{{ $t('forms.signIn') }}</router-link>
          <br />
          <router-link to="/forgot_password">{{ $t('forms.forgotPassword') }}</router-link>
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
       password_confirmation: ''
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
       const e = (error.response && error.response.data && error.response.data.error) || this.$t('errors.general')
       this.$store.commit('addAlert', { type: 'error', message: e})
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
