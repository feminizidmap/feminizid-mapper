<template>
<div>
  <div v-if="hasNewCase" class="text-center border border-4  p-4">
    <p>Du bearbeitest Fall <strong>{{ $store.state.newCase.ident}}</strong>.</p>

    <p><router-link :to="{ name: 'CaseNewMeta' }" class="btn btn-primary">
        Trage Infos zum Fall ein
        <i class="fas fa-arrow-circle-right"></i></router-link>
    </p>

    <hr class="border border-top border-2 border-secondary">
    <router-link :to="{ name: 'CaseNewFinish' }" class="btn btn-outline-primary mx">Diesen Fall speichern und abschließen</router-link>

    <button class="btn btn-outline-primary mx-4"
            @click.prevent="clearNewCase">Neuen Fall starten</button>
  </div>
  <div v-else class="text-center border border-4  p-4">
    <h3 class="my-4">Starte hier um einen neuen Fall einzutragen!</h3>
    <button
      v-if="isLoading"
      class="btn btn-primary" type="button" disabled>
      <span class="spinner-border spinner-border-sm" role="status" aria-hidden="true"></span>
      <span class="visually-hidden">Loading...</span>
    </button>
    <button v-else class="btn btn-primary"
            @click.prevent="createNewCase">Mit neuem Fall Starten</button>
  </div>
</div>
</template>
<script>

export default {
  name: 'CaseWizard',
  data() {
    return {
      isLoading: false
    }
  },
  created() {
    //debugger //  eslint-disable-line
  },
  methods: {
    createNewCase() {
      this.isLoading = true
      let d = new Date()
      const identTemp = `${d.getFullYear()}-${ ('0' + (d.getMonth() + 1)).slice(-2) }-${d.getDate() }-xx`
      this.$http.secured.post('/case/', { fcase: { 'ident': identTemp}})
        .then(response => {
          this.$store.commit('setNewCase', response.data)
          this.$store.commit('pushNewCaseHistory', { message: `Neuer Fall begonnen (${identTemp})`, date: d, type: 'info' })
          this.isLoading = false
        })
        .catch(error => {
          this.$store.commit('addAlert', { message: error, type: 'danger' })
          this.isLoading = false
        })
    },
    clearNewCase() {
      this.$store.commit('clearNewCase')
      this.$store.commit('clearNewCaseHistory')
    }
  },
  computed: {
    hasNewCase() {
      return !this.$store.getters.isNewCaseEmpty
    }
  }
}
</script>
