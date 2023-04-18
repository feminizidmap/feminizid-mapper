<template>
<div>
  <div v-if="hasCurrentRecord" class="text-center border border-4  p-4">
    <p>Fall <strong>{{ $store.state.currentRecord.identifier}}</strong></p>
    <p>@todo render summary</p>

    <button
      v-if="isLoading"
      class="btn btn-primary" type="button" disabled>
      <span class="spinner-border spinner-border-sm" role="status" aria-hidden="true"></span>
      <span class="visually-hidden">Loading...</span>
    </button>
    <button v-else class="btn btn-primary"
            @click.prevent="saveCurrentRecord">Fall speichern</button>
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
    saveCurrentRecord() {
      this.isLoading = true;
      console.log("Saving new record");
      let nR = this.$store.state.currentRecord;

      console.log(nR.sources.length)

      let sources = JSON.parse(JSON.stringify(nR.sources))

      console.log(sources.length)

      let entities = !nR.entities ? [] : nR.entities.map((e) => {
        let properties = e.properties.map((p) => {
          return {
            name: p.name,
            value: p.value,
            _destroy: p._destroy,
            id: p.id,
          };
        });

        return {
          name: e.name,
          description: e.description,
          _destroy: e._destroy,
          id: e.id,
          properties_attributes: properties,
        };
      });

      this.$httpSecured
        .patch(`/records/${nR.id}`, {
          record: {
            identifier: nR.identifier,
            sources_attributes: sources,
            entities_attributes: entities,
          },
        })
        .then((response) => {
          console.log("Saved!");
          this.$store.commit("updateSingleRecord", response.data);
          console.log("RESPONSE DATA")
          console.log(response.data)
          this.isLoading = false;
          console.log(this.$store.state.currentRecord.sources.length)
          this.$router.replace("/records/");
        })
        .catch((error) => {
          this.$store.commit("addAlert", {
            message: `Error: ${error}`,
            type: "error",
          });
        });
    },

    createCurrentRecord() { //TODO for save and directly create new record option
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
  },
  computed: {
    hasCurrentRecord() {
      return !this.$store.getters.isCurrentRecordEmpty
    }
  }
}
</script>
