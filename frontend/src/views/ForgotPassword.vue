<template>
  <div class="container-fluid mt-5">
    <div class="row justify-content-center">
      <form class="form-signup col-md-4 col-lg-3  text-center" @submit.prevent="submit">
        <h2 class="mb-4">{{ $t('prompts.forgotpassword') }}</h2>
        <div class="form-floating mb-4">
          <input v-model="email" type="email" class="form-control" id="email" placeholder="email@example.com" required>
          <label for="email" class="form-label">{{ $t('forms.email') }}</label>
        </div>
        <button type="submit" class="btn btn-lg btn-primary w-100 mb-4">{{ $t('forms.resetPassword') }}</button>
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
       email: ''
     }
   },
   methods: {
     submit() {
       this.$http.plain.post('/password_resets', { email: this.email })
           .then(() => this.submitSuccessful())
           .catch(error => this.submitFailed(error))
     },
     submitSuccessful() {
       this.$store.commit('addAlert', { type: 'notice', message: this.$t('resetPassword.mailSent')})
       this.email = ''
     },
     submitFailed(error) {
       const e = (error.response && error.response.data && error.response.data.error) || this.$t('errors.general')
       this.$store.commit('addAlert', { type: 'error', message: e})
     }
   }
 }
</script>
