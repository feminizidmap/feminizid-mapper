<template>
<div class="cases-list">
  LIST COMPONENT
  <ul v-if="filteredCases && filteredCases.length">
    <li v-for="fcase in filteredCases"
        :key="fcase.id">
      {{ fcase.attributes.ident }}
    </li>
  </ul>
  <div v-else class="alert alert-info" role="alert">
    Nothing here yet
  </div>
</div>
</template>
<script>
export default {
  name: 'CasesList',
  props: ['cases'],
  data() {
    return {
    }
  },
  created() {
    //this.$http.secured.get('/case/')
    //    .then(response => { this.cases = response.data.data })
    //    .catch(error => this.$store.commit('addAlert', { type: 'error', message: error}))
    //debugger // eslint-disable-line no-debugger
  },
  computed: {
    filteredCases() {
      return this.cases;
    }
  }
}

</script>
