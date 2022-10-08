<template>
<div>
  <div v-if="hasNewRecord" class="text-center border border-4  p-4">
    <p>Fall <strong>{{ $store.state.newRecord.identifier}}</strong></p>
    <p>@todo render summary</p>

    <button
      v-if="isLoading"
      class="btn btn-primary" type="button" disabled>
      <span class="spinner-border spinner-border-sm" role="status" aria-hidden="true"></span>
      <span class="visually-hidden">Loading...</span>
    </button>
    <button v-else class="btn btn-primary"
            @click.prevent="saveNewRecord">Fall speichern</button>
  </div>
</div>
</template>
<script>

export default {
  name: 'RecordFinish',
  data() {
    return {
      isLoading: false
    }
  },
  methods: {
    saveNewRecord() {
      this.isLoading = true
      console.log("Saving new record")
      let nR = this.$store.state.newRecord

      this.$httpSecured.patch(`/records/${nR.id}`, {
        record: {
          identifier: nR.identifier,
          sources: nR.sources
        }
      }).then(response => {
        console.log("Saved!")
        this.$store.commit('updateSingleRecord', response.data)
        this.isLoading = false
      }).catch(error => { this.$store.commit('addAlert', { message: `Error bill robinson ${error}`, type: 'error'})})
    }
  },
  computed: {
    hasNewRecord() {
      return !this.$store.getters.isNewRecordEmpty
    }
  }
}
</script>
