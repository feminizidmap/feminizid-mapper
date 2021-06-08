<template>
<div class="codelists container-fluid">
  <div class="my-2 d-flex justify-content-between align-content-center">
    <h1>{{ $t('layout.caselist') }}</h1>
    <div>
      <router-link to="/cases/new" class="btn btn-primary">Neuer Fall</router-link>
    </div>
  </div>
  <div class="row">
    <p>@todo write something about this view</p>
    <hr>
    <router-view></router-view>
  </div>
</div>
</template>
<script>
export default {
  name: 'CaseList',
  created () {
    if (this.$store.state.signedIn) {
      this.populateCases()
    } else {
      this.$router.replace('/')
    }
  },
  methods: {
    populateCases() {
      this.$http.secured.get('/case')
        .then(response => {
          this.$store.commit('setCases', response.data.data)
        })
        .catch(error => { this.setError(error, 'Something went wrong') })
    },
    setError (error, text) {
      const e = (error.response && error.response.data && error.response.data.error) || text
      this.$store.commit('addAlert', { type: 'error', message: e})
    }
  }
}
</script>
