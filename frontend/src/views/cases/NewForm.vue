<template>
<div class="codelists container-fluid">
  <div class="row">
    <nav aria-label="breadcrumb">
      <ol class="breadcrumb">
        <li class="breadcrumb-item"><router-link to="/cases">Alle Fälle</router-link></li>
        <li class="breadcrumb-item active" aria-current="page">Neuer Fall</li>
      </ol>
    </nav>
  </div>
  <div class="row mt-4 mb-3">
    <h2>Neuer Fall hinzufügen</h2>
  </div>
  <div class="row my-2">
    <div class="col col-2">
      <div v-if="!$store.getters.isNewCaseEmpty">
        <p>{{ $store.state.newCase.ident }}</p>

        <div>
          @todo status
          {{ $store.state.newCaseHistory.length }}
        </div>
      </div>
      <nav>
        <ul class="nav nav-pills flex-column">
          <li class="nav-item">
            <router-link :to="{ name: 'CaseNewWizard' }" class="nav-link">Wizard</router-link>
          </li>
          <li><hr></li>
          <li class="nav-item">
            <router-link :to="{ name: 'CaseNewMeta' }" class="nav-link">Meta</router-link>
          </li>
          <li class="nav-item">
            <router-link :to="{ name: 'CaseNewCrime' }" class="nav-link">Tat</router-link>
          </li>
          <li class="nav-item">
            <router-link :to="{ name: 'CaseNewVictim' }" class="nav-link">Opfer</router-link>
          </li>
          <li class="nav-item">
            <router-link :to="{ name: 'CaseNewPerpetrator' }" class="nav-link">Täter</router-link>
          </li>
          <li><hr></li>
          <li class="nav-item">
            <router-link :to="{ name: 'CaseNewFinish' }" class="nav-link">Zusammenfassung</router-link>
          </li>
        </ul>
      </nav>

    </div>
    <div class="col col-7">
      {{ $store.state.newCase }}
      <router-view></router-view>
    </div>
    <div class="col col-3">
      <aside v-if="$store.state.newCaseHistory.length > 0">
        <h4>Neuer Fall Schritte</h4>
        <ol>
          <li v-for="(item, i) in $store.state.newCaseHistory" :key="i">
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
  name: 'CaseForm',
  data() {
    return {
      isLoading: false
    }
  },
  created() {

  },
  methods: {
    formattedDate(datestr) {
      let d = new Date(datestr)
      return d.toLocaleTimeString('de-DE')
    },

  }
}
</script>
