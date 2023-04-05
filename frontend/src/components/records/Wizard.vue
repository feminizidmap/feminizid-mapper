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
    <h1 class="fs-1 fw-bold">Neuen Fall hinzufügen</h1>
  </div>
  <div class="row my-2">
    <div class="col col-2">
      <div v-if="!$store.getters.isNewRecordEmpty">
        <p>Du bearbeitest Fall <strong>{{ $store.state.newRecord.identifier}}</strong>.</p>

        <div>
          @todo status
          {{ $store.state.newRecordHistory.length }}
        </div>
      </div>
      <nav>
        <ul class="nav nav-pills flex-column">
          <li class="nav-item"
            v-for="step in steps"
            :key="step.id"
          >
            <router-link 
              :to="step.link" 
              class="nav-link"
            >
              {{ step.name }}
            </router-link>
          </li>
        </ul>
      </nav>

    </div>
    <div class="col col-7">
      <div v-if="hasNewRecord" class="h-100 d-flex flex-column">
        <router-view :key="$route.path"></router-view>
        <WizardControl :steps="steps" />
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
                @click.prevent="createNewRecord">Mit neuem Fall Starten</button>
      </div>
    </div>
    <div class="col col-3 d-flex flex-column">
      <aside v-if="$store.state.newRecordHistory.length > 0">
        <h4>Neuer Fall Schritte</h4>
        <ol>
          <li v-for="(item, i) in $store.state.newRecordHistory" :key="i">
            <span :class="`badge bg-${item.type}`">{{item.type}}</span> {{item.message}} <span class="text-secondary">{{ formattedDate(item.date) }}</span>
          </li>
        </ol>
      </aside>
      <div v-if="hasNewRecord" class="mt-auto">
        <button class="btn btn-outline-primary mx-4" @click.prevent="clearNewRecord">Abbrechen</button>
        <router-link :to="{ name: 'RecordNewFinish' }" class="btn btn-outline-primary mx">Diesen Fall speichern und abschließen</router-link>
      </div>
    </div>
  </div>
</div>
</template>
<script>
import WizardControl from '@/components/records/WizardControl'

export default {
  name: 'Wizard',
  props: { steps: Array },
  components: { WizardControl },
  data() {
    return {
      isLoading: false,
      schemaSetting: null,
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
    },
    createNewRecord() {
      this.isLoading = true
      let d = new Date()
      const identTemp = `${d.getFullYear()}-${ ('0' + (d.getMonth() + 1)).slice(-2) }-${d.getDate() }-xx`
      this.$httpSecured.post('/records/', { record: { 'identifier': identTemp}})
        .then(response => {
          this.$store.commit('setNewRecord', response.data)
          this.$store.commit('pushNewRecordHistory', { message: `Neuer Fall begonnen (${identTemp})`, date: d, type: 'info' })
          this.isLoading = false
          this.$router.replace('/records/new/meta')
        })
        .catch(error => {
          this.$store.commit('addAlert', { message: error, type: 'danger' })
          this.isLoading = false
        })
    },
    clearNewRecord() {
      this.$store.commit('clearNewRecord')
      this.$store.commit('clearNewRecordHistory')
      this.$router.replace('/records/new')
    }
  },
  computed: {
    hasNewRecord() {
      return !this.$store.getters.isNewRecordEmpty
    }
  }
}
</script>
