<template>
<div class="container-fluid">
  <div class="row">
    <h2 class="h1">{{ $t('layout.schema.title') }}</h2>
    <p class="fs-5" v-html="$t('layout.schema.blurb')"></p>
    <hr>
  </div>
  <div class="row mt-3">
    <div v-if="$store.state.schema !== {}" class="text-end">
      Something something safe state
        <button @click="persistSchema" class="btn btn-outline-primary me-2">
            <i class="fa fa-save"></i>
            <span class="visually-hidden">{{ $t('forms.save') }}</span></button>
    </div>

    <div>
      <h3 class="h2">{{ $t('layout.schema.record.title') }}</h3>
      <p>{{ $t('layout.schema.record.blurb') }}</p>
    </div>
    <div class="mt-4">
      <h4>{{ $t('layout.schema.entity.title') }}</h4>
      <p>{{ $t('layout.schema.entity.blurb') }}</p>
      <div>
        <NewEntityItem @newEntity="saveNewEntity">
          <i class="far fa-plus-square"></i>
          Hinzufügen
        </NewEntityItem>
        <ul v-if="$store.state.schema.length > 0"
          class="mt-4 ms-3 ps-0 list-unstyled">

          <li class="border-start border-3 mb-4 ps-3"
              v-for="(entity, i) in $store.state.schema"
              :key="i">
            <EntityItem :entity="entity"
                        :ident="i"
                        @newField="saveNewField"
                        @rmField="saveRmField"
                        @rmEntity="saveRmEntity"
                        @updateEntity="updateEntity "
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
    updateEntity(e) {
      let schema = this.$store.state.schema
      let index = schema.indexOf(e.old)
      let attrs = schema[index].attributes
      schema[index] = e.mew
      schema[index].attributes = attrs
      this.$store.commit('setSchema', schema)
    },
    saveNewEntity(nE) {
      let schema = this.$store.state.schema
      if (!nE.attributes) {
        nE.attributes = []
      }
      schema.push(nE)
      this.$store.commit('setSchema', schema)
    },
    saveNewField(obj) {
      let schema = this.$store.state.schema
      let index = schema.indexOf(obj.e)
      schema[index].attributes.push(obj.field)
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
