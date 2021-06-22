<template>
<div>
  <div v-if="hasNewCase" class="text-center border border-4  p-4">
    <p>Fall <strong>{{ $store.state.newCase.ident}}</strong></p>
    <p>@todo render summary</p>

    <button
      v-if="isLoading"
      class="btn btn-primary" type="button" disabled>
      <span class="spinner-border spinner-border-sm" role="status" aria-hidden="true"></span>
      <span class="visually-hidden">Loading...</span>
    </button>
    <button v-else class="btn btn-primary"
            @click.prevent="saveNewCase">Fall speichern</button>
  </div>
</div>
</template>
<script>

export default {
  name: 'CaseFinish',
  data() {
    return {
      isLoading: false
    }
  },
  methods: {
    saveNewCase() {
      this.isLoading = true
      console.log("Saving new case")
      let nC = this.$store.state.newCase

      this.$http.secured.patch(`/case/${nC.id}`, {
        fcase: {
          ident: nC.ident,
          sources: nC.sources
        }
      }).then(response => {
        this.$store.commit('updateSingleCase', response.data)
        this.isLoading = false
      }).catch(error => { this.$store.commit('addAlert', { message: `Error bill robinson ${error}`, type: 'error'})})
    }
  },
  computed: {
    hasNewCase() {
      return !this.$store.getters.isNewCaseEmpty
    }
  }
}
</script>
