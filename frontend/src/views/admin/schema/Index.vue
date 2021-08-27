<template>
<div class="container-fluid">
  <div class="row">
    <h2 class="h1">{{ $t('layout.schema.title') }}</h2>
    <p class="fs-5" v-html="$t('layout.schema.blurb')"></p>
    <hr>
  </div>
  <div class="row mt-3">
    <SaveIndicator @persistSchema="persistSchema" :isLoading="isLoading" />
    <div class="mt-4">
      <h3>{{ $t('layout.schema.entity.title') }}</h3>
      <p>{{ $t('layout.schema.entity.blurb') }}</p>
      <div>
        <NewEntityItem @newEntity="saveNewEntity" v-if="showIfAdmin">
          <i class="far fa-plus-square"></i>
          {{ $t('actions.new') }}
        </NewEntityItem>
        <ul v-if="$store.state.schema.length > 0"
          class="mt-4 ms-1 ps-0 list-unstyled">
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
import SaveIndicator from '@/components/schema/SaveIndicator'

export default {
  name: 'Schema',
  components: { EntityItem, NewEntityItem, SaveIndicator },
  data() {
    return {
      isLoading: false
    }
  },
  methods: {
    updateEntity(e) {
      let schema = this.$store.state.schema
      let index = schema.indexOf(e.old)
      let attrs = schema[index].attributes
      schema[index] = e.mew
      schema[index].attributes = attrs
      this.$store.commit('setSchema', schema)
      this.$store.commit('setSchemaHasChanged', true)
    },
    saveNewEntity(nE) {
      let schema = this.$store.state.schema
      if (!nE.attributes) {
        nE.attributes = []
      }
      schema.push(nE)
      this.$store.commit('setSchema', schema)
      this.$store.commit('setSchemaHasChanged', true)
    },
    saveNewField(obj) {
      let schema = this.$store.state.schema
      let index = schema.indexOf(obj.e)
      schema[index].attributes.push(obj.field)
      this.$store.commit('setSchema', schema)
      this.$store.commit('setSchemaHasChanged', true)
    },
    saveRmField(item) {
      let schema = this.$store.state.schema
      const eIndex = schema.indexOf(item.e)
      const aIndex = schema[eIndex].attributes.indexOf(item.a)
      schema[eIndex].attributes.splice(aIndex, 1)
      this.$store.commit('setSchema', schema)
      this.$store.commit('setSchemaHasChanged', true)
    },
    saveRmEntity(entity) {
      let schema = this.$store.state.schema
      const eIndex = schema.indexOf(entity)
      schema.splice(eIndex, 1)
      this.$store.commit('setSchema', schema)
      this.$store.commit('setSchemaHasChanged', true)
    },
    persistSchema() {
      this.isLoading = true
      let schemaSettingsId = this.$store.getters.getSetting('settings_schema')
      if (schemaSettingsId) {
        this.$http.secured.patch(`/system_settings/${schemaSettingsId.id}`,
                                 { system_setting:
                                   { 'key': 'settings_schema',
                                     value: JSON.stringify(this.$store.state.schema)}})
          .then(() => {
            this.$store.commit('setSchemaHasChanged', false)
            this.$store.commit('addAlert', { message: this.$t('notice.schemaSet'), type: 'notice' })
          })
          .catch(() => {
            this.$store.commit('addAlert', { message: this.$t('notice.schemaNotSet'), type: 'danger' })
          })
          .finally(() => { this.isLoading = false })
      } else {
        this.$http.secured.post(`/system_settings/`,
                                { system_setting:
                                  { 'key': 'settings_schema',
                                    value: JSON.stringify(this.$store.state.schema)}})
          .then(() => {
            this.$store.commit('setSchemaHasChanged', false)
            this.$store.commit('addAlert', { message: this.$t('notice.schemaSet'), type: 'notice' })
          })
          .catch(() => {
            this.$store.commit('addAlert', { message: this.$t('notice.schemaNotSet'), type: 'danger' })
          })
          .finally(() => { this.isLoading = false })
      }
    },
    setLoadingFlag() {
      this.isLoading = this.$store.state.settings.length > 0 ? false : true
    },
    setActiveSchema() {
      let schemaSetting = this.$store.getters.getSetting('settings_schema')
      if (schemaSetting) {
        this.$store.commit('setSchema', JSON.parse(schemaSetting.value))
        this.$store.commit('setSchemaHasChanged', false)
      } else {
        this.$store.commit('setSchema', [])
        this.$store.commit('setSchemaHasChanged', false)
      }
    }
  },
  watch: {
    '$store.state.settings': {
      handler() {
        this.setLoadingFlag()
        this.setActiveSchema()
      }
    }
  },
  computed: {
    showIfAdmin() {
      return this.$store.getters.isAdmin
    }
  }
}
</script>
