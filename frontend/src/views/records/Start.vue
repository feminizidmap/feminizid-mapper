<template>
<div>
  <div v-if="hasCurrentRecord" class="text-center border border-4  p-4">
    @todo Infos über das aktuelle Datenschema (?)
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
            @click.prevent="createCurrentRecord">Mit neuem Fall Starten</button>
  </div>
</div>
</template>
<script>

export default {
  name: 'RecordStart',
  data() {
    return {
      isLoading: false
    }
  },
  created() {
    //debugger //  eslint-disable-line
  },
  methods: {
    createCurrentRecord() {
      this.isLoading = true
      let d = new Date()
      const identTemp = `${d.getFullYear()}-${ ('0' + (d.getMonth() + 1)).slice(-2) }-${d.getDate() }-xx`
      this.$httpSecured.post('/records/', { record: { 'identifier': identTemp}})
        .then(response => {
          this.$store.commit('setCurrentRecord', response.data)
          this.$store.commit('pushCurrentRecordHistory', { message: `Neuer Fall begonnen (${identTemp})`, date: d, type: 'info' })
          this.isLoading = false
        })
        .catch(error => {
          this.$store.commit('addAlert', { message: error, type: 'danger' })
          this.isLoading = false
        })
    },
    clearCurrentRecord() {
      this.$store.commit('clearCurrentRecord')
      this.$store.commit('clearCurrentRecordHistory')
    }
  },
  computed: {
    hasCurrentRecord() {
      return !this.$store.getters.isCurrentRecordEmpty
    }
  }
}
</script>
