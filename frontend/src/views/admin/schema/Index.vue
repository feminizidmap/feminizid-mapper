<template>
<div class="container-fluid">
  <div class="row">
    <h2 class="h1">{{ $t('layout.schema') }}</h2>
    <p class="fs-5">The schema defines the structure of the data, that means the possible fields on a single record.<br>Think of it as the columns in a spreadsheet.</p>
    <hr>
  </div>
  <div class="row mt-5">
    <div>
      <h3 class="h2">Record</h3>
      <p>Record is a single datum, one entry in your database. Everything starts here.</p>
      <div v-if="$store.state.schema !== {}">
        <button type="button" class="btn btn-primary"
                @click="persistSchema">SAVE</button>
    </div>
    </div>
    <div class="mt-4">
      <h4>Entities</h4>
      <p>Entities group logical information together. Usually the entities are Victim, Perpetrator, Crime but you can have more if you want</p>
      <div>
        <NewEntityItem @newEntity="saveNewEntity"></NewEntityItem>
        <ul v-if="$store.state.schema.length > 0"
          class="mt-4 ms-3 border-start border-4">

          <li class="mt-4"
              v-for="(entity, i) in $store.state.schema"
              :key="i">
            <EntityItem :entity="entity"
                        @newField="saveNewField"
                        @newAttribute="saveNewField"
                        @rmField="saveRmField"
                        @rmEntity="saveRmEntity"
                        ></EntityItem>
          </li>
        </ul>
      </div>
    </div>
  </div>
</div>
</template>
<script>
import EntityItem from '@/components/schema/EntityItem'
import NewEntityItem from '@/components/schema/NewEntityItem'

export default {
  name: 'Schema',
  components: { EntityItem, NewEntityItem },
  methods: {
    saveNewEntity(nE) {
      let schema = this.$store.state.schema;
      if (!nE.attributes) {
        nE.attributes = []
      }
      schema.push(nE)
      this.$store.commit('setSchema', schema)
    },
    saveNewField(all) {
      let schema = this.$store.state.schema
      let index = schema.indexOf(all.e)
      schema[index].attributes.push(all.field)
      this.$store.commit('setSchema', schema)
    },
    saveRmField(item) {
      let schema = this.$store.state.schema
      const eIndex = schema.indexOf(item.e)
      const aIndex = schema[eIndex].attributes.indexOf(item.a)
      schema[eIndex].attributes.splice(aIndex, 1)
      this.$store.commit('setSchema', schema)
    },
    saveRmEntity(entity) {
      let schema = this.$store.state.schema
      const eIndex = schema.indexOf(entity)
      schema.splice(eIndex, 1)
      this.$store.commit('setSchema', schema)
    },
    persistSchema() {
      this.$http.secured.patch(`/system_settings/bb799735-d85d-42dc-a5a7-7adff46b80b4`,
                              { system_setting:
                                { 'key': 'schema',
                                  value: JSON.stringify(this.$store.state.schema)}})
        .then(() => {
          this.$store.commit('addAlert', { message: "New Schema set", type: 'info' })
        })
        .catch(error => {
          this.$store.commit('addAlert', { message: error, type: 'danger' })
          this.isLoading = false
        })
    }
  }
}
</script>
