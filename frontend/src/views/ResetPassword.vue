<template>
  <div class="container-fluid mt-5">
    <div class="alert alert-info" v-if="notice">{{ notice }}</div>
    <div class="alert alert-danger" v-if="error">{{ error }}</div>
    <div class="row justify-content-center">
      <form class="form-app form-reset-password col-sm-3" @submit.prevent="reset">
        <div class="form-group mb-4">
          <label for="password" class="form-label">{{ $t('forms.newPassword') }}</label>
          <input v-model="password" type="password" class="form-control" id="password" placeholder="Password">
        </div>
        <div class="form-group mb-4">
          <label for="password_confirmation" class="form-label">{{ $t('forms.passwordConfirmation') }}</label>
          <input v-model="password_confirmation" type="password" class="form-control" id="password_confirmation" placeholder="Password Confirmation">
        </div>
        <button type="submit" class="btn btn-primary mb-3">{{ $t('forms.resetPassword') }}</button>
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
       password_confirmation: '',
       error: '',
       notice: ''
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
       this.notice = this.$t('resetPassword.resetSuccessful')
       this.error = ''
       this.password = ''
       this.password_confirmation = ''
     },
     resetFailed(error) {
       this.error = (error.response && error.response.data && error.response.data.error) || 'Something went wrong'
       this.notice = ''
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
