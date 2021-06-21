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


          <button v-if="isLoading" class="btn btn-primary" type="button" disabled>
            <span class="spinner-grow spinner-grow-sm" role="status" aria-hidden="true"></span>
            Speichern...
          </button>
          <button v-else type="button"
                  class="btn btn-primary"
                  @click.prevent="saveNewCase">Speichern</button>
        </div>
      </div>
      <nav>
        <ul class="nav nav-pills flex-column">
          <li class="nav-item">
            <router-link :to="{ name: 'CaseNewMeta' }" class="nav-link">Quellen</router-link>
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
    saveNewCase() {
      this.isLoading = true
      console.log("Saving new case")
      let nC = this.$store.state.newCase

      // split nC into case, victim, perp and crime

      this.$http.secured.patch(`/case/${nC}`, {
        fcase: {
          ident: nC.ident,
          sources: nC.sources
        }
      }).then(response => {
        this.$store.commit('updateSingleCase', response.data)
        this.isLoading = false
      }).catch(error => { this.$store.commit('addAlert', { message: `Error bill robinson ${error}`, type: 'error'})})
    }
  }
}
</script>
