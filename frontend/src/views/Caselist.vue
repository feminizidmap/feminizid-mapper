<template>
<div class="codelists container-fluid">

  <div class="row">
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
      this.$httpSecured.get('/case')
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
