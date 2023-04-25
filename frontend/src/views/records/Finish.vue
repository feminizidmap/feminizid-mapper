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
      let cR = this.$store.state.currentRecord;

      let sources = JSON.parse(JSON.stringify(cR.sources))

      let entities = !cR.entities ? [] : cR.entities.map((e) => {
        let properties = e.properties.map((p) => {
          return {
            id: p.id,
            name: p.name,
            value: p.value, // TODO category_id and category_item_id
          };
        });

        let fields = e.fields.map((f) => {
          return {
            id: f.id,
            name: f.name,
            value: f.value
          }
        })

        return {
          id: e.id,
          name: e.name,
          description: e.description,
          slug: e.slug,
          properties_attributes: properties,
          fields_attributes: fields
        };
      });

      console.log("Entities object:", entities)

      this.$httpSecured
        .patch(`/records/${cR.id}`, {
          record: {
            identifier: cR.identifier,
            sources_attributes: sources,
            entities_attributes: entities,
          },
        })
        .then((response) => {
          console.log("Saved!");
          this.$store.commit("updateSingleRecord", response.data);
          this.isLoading = false;
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
