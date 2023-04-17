<template>
<div class="codelists container-fluid">
  <div class="row">
    <nav aria-label="breadcrumb">
      <ol class="breadcrumb">
        <li class="breadcrumb-item"><router-link to="/records">Alle Fälle</router-link></li>
        <li v-if="isNewRecord" class="breadcrumb-item active" aria-current="page">Neuer Fall</li>
        <li v-if="!isNewRecord" class="breadcrumb-item active" aria-current="page">Fall bearbeiten</li>
      </ol>
    </nav>
    <hr>
  </div>
  <div class="row mt-3 mb-4">
    <h1 v-if="$store.getters.isCurrentRecordEmpty" class="fs-1 fw-bold">Neuen Fall hinzufügen</h1>
  </div>
  <div class="row my-2">
    <div class="col col-2">
      <div v-if="!$store.getters.isCurrentRecordEmpty">
        <p>Du bearbeitest Fall <strong>{{ $store.state.currentRecord.identifier}}</strong>.</p>

        <div>
          @todo status
          {{ $store.state.currentRecordHistory.length }}
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
      <div class="h-100 d-flex flex-column">
        <router-view :key="$route.path"></router-view>
        <WizardControl :steps="steps" />
      </div>
    </div>
    <div class="col col-3 d-flex flex-column">
      <aside v-if="$store.state.currentRecordHistory.length > 0">
        <h4>History</h4>
        <ol>
          <li v-for="(item, i) in $store.state.currentRecordHistory" :key="i">
            <span :class="`badge bg-${item.type}`">{{item.type}}</span> {{item.message}} <span class="text-secondary">{{ formattedDate(item.date) }}</span>
          </li>
        </ol>
      </aside>
      <div class="mt-auto">
        <button class="btn btn-outline-primary mx-4" @click.prevent="clearRecord">Abbrechen</button>
        <router-link :to="{ name: isNewRecord ? 'RecordNewFinish' : 'RecordEditFinish'  }" class="btn btn-outline-primary mx">Diesen Fall speichern und abschließen</router-link>
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
      isLoading: false
    }
  },
  methods: {
    formattedDate(datestr) {
      let d = new Date(datestr)
      return d.toLocaleTimeString('de-DE')
    },
    clearRecord() {
      this.$store.commit('clearCurrentRecord')
      this.$store.commit('clearCurrentRecordHistory')
      this.$router.replace('/records/')
    }
  },
  computed: {
    isNewRecord() {
      return this.$store.getters.isCurrentRecordNew
    }
  }
}
</script>
