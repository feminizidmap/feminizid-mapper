<template>
  <div class="container text-center mt-3">
    <h2>{{ $t('forms.profileSettings') }}</h2>
    <div class="d-flex justify-content-center align-items-center mt-2">
      
      <div class="alert alert-info" v-if="notice">{{ notice }}</div>
      <div class="alert alert-danger" v-if="error">{{ error }}</div>
      <form @submit.prevent="update">
        <div class="form-floating mb-1">
          <input v-model="user.email" type="email" class="form-control" id="email" @change="edited = true">
          <label for="email" class="form-label">{{ $t('forms.email') }}</label>
        </div>
        <div class="form-floating mb-4">
          <input v-model="user.name" type="name" class="form-control" id="name" @change="edited = true">
          <label for="name" class="form-label">{{ $t('forms.name') }}</label> 
        </div>
        <button type="submit" class="btn btn-primary w-100 mb-4">{{ $t('forms.save') }}</button>
      </form>
    </div>
    <div>
      <button class="btn btn-outline-primary"
          type="button"
          @click.prevent="changePassword">{{ $t('forms.changePassword') }}</button>
    </div>
  </div>
</template>

<script>
export default {
  name: 'Profile',
  data() {
    return {
      error: '',
      notice: '',
      user: {},
      edited: false
    }
  },
  created () {
    this.checkSignedIn()
  },
  methods: {
    checkSignedIn() {
      if (this.$store.state.signedIn) {
        this.initialize();
      } else {
        this.$router.replace('/signin')
      }
    },
    initialize() {
      this.$httpSecured.get(`/users/${this.$store.getters.currentUserId}`)
        .then(response => {
          this.user = response.data.data;
        })
        .catch(error => { this.setError(error, 'Something went wrong') })
    },
    setError (error, text) {
      this.error = (error.response && error.response.data && error.response.data.error) || text
    },
    update() {
      if (this.edited) {
        this.$httpSecured.put(`/users/${this.user.id}`, { 
          user: { 
            email: this.user.email,
            name: this.user.name 
            } })
        .then(response => this.updateSuccessful(response))
        .catch(error => this.updateFailed(error))
      }
    },
    updateSuccessful() {
      this.notice = 'Profile updated'
      this.error = ''
    },
    updateFailed(error) {
      this.error = (error.response && error.response.data && error.response.data.error) || ''
      this.notice = ''
    },
    changePassword() {
      this.$router.replace('/password_resets/' + this.user.reset_password_token)
    }
  }
}
</script>