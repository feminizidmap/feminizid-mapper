<template>
  <div class="container-fluid mt-5">
    <div class="row justify-content-center">
      <form class="col-sm-3 text-center" @submit.prevent="signin">
        <h2 class="mb-4">{{ $t('prompts.signin') }}</h2>
        <div class="form-floating mb-1">
          <input v-model="email" type="email" class="form-control" id="email" placeholder="email@example.com">
          <label for="email" class="form-label">{{ $t('forms.email') }}</label>
        </div>
        <div class="form-floating mb-4">
          <input v-model="password" type="password" class="form-control" id="password" placeholder="Password">
          <label for="password" class="form-label">{{ $t('forms.password') }}</label>

        </div>
        <button type="submit" class="btn btn-lg btn-primary w-100 mb-4">{{ $t('forms.signIn') }}</button>
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
       password: ''
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
       const e = (error.response && error.response.data && error.response.data.error) || ''
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
