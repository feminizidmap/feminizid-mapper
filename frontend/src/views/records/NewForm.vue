<template>
<div class="codelists container-fluid">
  <div class="row">
    <nav aria-label="breadcrumb">
      <ol class="breadcrumb">
        <li class="breadcrumb-item"><router-link to="/records">Alle Fälle</router-link></li>
        <li class="breadcrumb-item active" aria-current="page">Neuer Fall</li>
      </ol>
    </nav>
    <hr>
  </div>
  <div class="row mt-3 mb-4">
    <h1 class="fs-1 fw-bold">Neuer Fall hinzufügen</h1>
  </div>
  <div class="row my-2">
    <div class="col col-2">
      <div v-if="!$store.getters.isNewRecordEmpty">
        <p>{{ $store.state.newRecord.identifier }}</p>

        <div>
          @todo status
          {{ $store.state.newRecordHistory.length }}
        </div>
      </div>
      <nav>
        <ul class="nav nav-pills flex-column">
          <li class="nav-item">
            <router-link :to="{ name: 'RecordNewWizard' }" class="nav-link">Wizard</router-link>
          </li>
          <li><hr></li>
          <li class="nav-item">
            <router-link :to="{ name: 'RecordNewMeta' }" class="nav-link">Meta</router-link>
          </li>
          <li class="nav-item">
            <router-link :to="{ name: 'RecordNewCrime' }" class="nav-link">Tat</router-link>
          </li>
          <li class="nav-item">
            <router-link :to="{ name: 'RecordNewVictim' }" class="nav-link">Opfer</router-link>
          </li>
          <li class="nav-item">
            <router-link :to="{ name: 'RecordNewPerpetrator' }" class="nav-link">Täter</router-link>
          </li>
          <li><hr></li>
          <li class="nav-item"
            v-for="entity in schemaSetting"
            :key="entity.id"
          >
            <router-link 
              :to="{name: 'RecordNewEntity', 
                    params: { entityname: entity.name }, 
                    query: { attributes: JSON.stringify(entity.attributes) } }" 
                    class="nav-link"
            >
              {{ entity.name }}
            </router-link>
          </li>
          <li><hr></li>
          <li class="nav-item">
            <router-link :to="{ name: 'RecordNewFinish' }" class="nav-link">Zusammenfassung</router-link>
          </li>
        </ul>
      </nav>

    </div>
    <div class="col col-7">
      <router-view :key="$route.path"></router-view>
    </div>
    <div class="col col-3">
      <aside v-if="$store.state.newRecordHistory.length > 0">
        <h4>Neuer Fall Schritte</h4>
        <ol>
          <li v-for="(item, i) in $store.state.newRecordHistory" :key="i">
            <span :class="`badge bg-${item.type}`">{{item.type}}</span> {{item.message}} <span class="text-secondary">{{ formattedDate(item.date) }}</span>
          </li>
        </ol>
      </aside>
    </div>
  </div>
</div>
</template>
<script>
export default {
  name: 'RecordForm',
  data() {
    return {
      isLoading: false,
      schemaSetting: null
    }
  },
  created() {
    this.schemaSetting = this.createSettingsSchemaObject()
  },
  methods: {
    formattedDate(datestr) {
      let d = new Date(datestr)
      return d.toLocaleTimeString('de-DE')
    },
    createSettingsSchemaObject() {
      const settings = this.$store.getters.getSetting('settings_schema') ? JSON.parse(this.$store.getters.getSetting('settings_schema').value) : []
      let settingsObject = [];

      settings.forEach(s => {
        settingsObject.push(s)
      })

      return settingsObject
    }
  }
}
</script>
