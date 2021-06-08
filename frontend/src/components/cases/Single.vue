<template>
<div class="cases-single">
  <h2 class="h1">{{ fcase.attributes.ident }}</h2>
</div>
</template>
<script>
export default {
  name: 'CasesSingle',
  props: ['item'],
  data() {
    return {

    }
  },
  created() {
    //this.$http.secured.get('/case/')
    //    .then(response => { this.cases = response.data.data })
    //    .catch(error => this.$store.commit('addAlert', { type: 'error', message: error}))

  },
  methods: {

  }
}

</script>
