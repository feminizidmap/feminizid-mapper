<template>
<div class="codelists container-fluid">
  <div class="row my-2">
    <h1 class="display-4">{{ $t('layout.caselist') }}</h1>
  </div>
  <div class="row">
    <p>@todo write something about this view</p>
    <hr>
    <router-view></router-view>
  </div>
</div>
</template>

<script>
//import { sortBy } from 'lodash'

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
          console.log(response.data.data)
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
