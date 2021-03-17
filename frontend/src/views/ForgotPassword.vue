<template>
  <div class="container-fluid mt-5">
    <div class="row justify-content-center">
      <div class="alert alert-info" v-if="notice">{{ notice }}</div>
      <div class="alert alert-danger" v-if="error">{{ error }}</div>
      <form class="form-signup col-sm-3" @submit.prevent="submit">
        <div class="form-group mb-4">
          <label for="email" class="form-label">{{ $t('forms.email') }}</label>
          <input v-model="email" type="email" class="form-control" id="email" placeholder="email@example.com">
        </div>
        <button type="submit" class="btn btn-primary mb-3">{{ $t('forms.resetPassword') }}</button>
        <div>
          <router-link to="/">{{ $t('forms.signIn') }}</router-link>
          <br />
          <router-link to="/signup">{{ $t('forms.signUp') }}</router-link>
        </div>
      </form>
    </div>
  </div>
</template>

<script>
 export default {
   name: 'ForgotPassword',
   data () {
     return {
       email: '',
       error: '',
       notice: ''
     }
   },
   methods: {
     submit () {
       this.$http.plain.post('/password_resets', { email: this.email })
           .then(() => this.submitSuccessful())
           .catch(error => this.submitFailed(error))
     },
     submitSuccessful () {
       this.notice = this.$t('resetPassword.mailSent')
       this.error = ''
       this.email = ''
     },
     submitFailed (error) {
       this.error = (error.response && error.response.data && error.response.data.error) || ''
     }
   }
 }
</script>
