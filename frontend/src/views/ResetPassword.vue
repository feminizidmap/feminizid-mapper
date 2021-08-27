<template>
  <div class="container-fluid mt-5">
    <div class="row justify-content-center">
      <form class="text-center col-md-4 col-lg-3 " @submit.prevent="reset">
        <h2 class="mb-4">{{ $t('prompts.resetpassword') }}</h2>
        <div class="form-floating mb-1">
          <input v-model="password" type="password" class="form-control" id="password" placeholder="Password">
          <label for="password" class="form-label">{{ $t('forms.newPassword') }}</label>
        </div>
        <div class="form-floating mb-4">
          <input v-model="password_confirmation" type="password" class="form-control" id="password_confirmation" placeholder="Password Confirmation">
          <label for="password_confirmation" class="form-label">{{ $t('forms.passwordConfirmation') }}</label>
        </div>
        <button type="submit" class="btn btn-lg btn-primary w-100 mb-4">{{ $t('forms.resetPassword') }}</button>
        <div>
          <router-link to="/">{{ $t('forms.signIn') }}</router-link>
        </div>
      </form>
    </div>
  </div>
</template>

<script>
 export default {
   name: 'ResetPassword',
   data() {
     return {
       password: '',
       password_confirmation: ''
     }
   },
   created() {
     this.checkPasswordToken()
   },
   methods: {
     reset() {
       this.$http.plain.patch(`/password_resets/${this.$route.params.token}`, { password: this.password, password_confirmation: this.password_confirmation })
           .then(response => this.resetSuccessful(response))
           .catch(error => this.resetFailed(error))
     },
     resetSuccessful() {
       this.$store.commit('addAlert', { type: 'notice', message: this.$t('resetPassword.resetSuccessful')})
       this.password = ''
       this.password_confirmation = ''
       this.$router.replace('/')
     },
     resetFailed(error) {
       const e = (error.response && error.response.data && error.response.data.error) || this.$t('errors.general')
       this.$store.commit('addAlert', { type: 'error', message: e})
     },
     checkPasswordToken() {
       this.$http.plain.get(`/password_resets/${this.$route.params.token}`)
           .catch(error => {
             this.resetFailed(error)
             this.$router.replace('/')
           })
     }
   }
 }
</script>
