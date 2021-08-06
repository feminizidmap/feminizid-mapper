<template>
<div class="dashboard">
  <div class="container-fluid">
    <div class="row">
      <h1 class="fs-1">{{ $t('dashboard.title') }}</h1>
      <hr>
    </div>
  </div>
  <div class="container-fluid mt-4">
    <div class="row">
      <section class="col-12 col-md-4">
        <div class="d-flex justify-content-between">
          <h2 class="h2">{{ $t('layout.caselist') }}</h2>
          <div>
          <router-link to="/cases" class="btn btn-outline-primary me-2">Alle {{ $t('layout.cases') }}</router-link>
          <router-link to="/cases/new" class="btn btn-primary">Neuer Fall</router-link>
          </div>
        </div>
        <CasesList :cases="cases">
          <CasesItemSimple v-for="fcase in cases"
                           :key="fcase.id"
                           :item="fcase" />
        </CasesList>
        <hr>
        <router-link to="/cases" class="btn btn-outline-primary">Alle {{ $t('layout.cases') }}</router-link>
      </section>
      <section class="col-12 col-md-3">
        <ChangesList />
      </section>
      <section class="col-12 col-md-4">
        @todo stats? summary?
      </section>
    </div>
  </div>
</div>
</template>

<script>
  import CasesList from '@/components/cases/List'
  import CasesItemSimple from '@/components/cases/ItemSimple'
import ChangesList from '@/components/changes/List'

export default {
  name: 'Dashboard',
  components: { CasesList, CasesItemSimple, ChangesList },
  data () {
    return {

    }
  },
  created () {
    if (!this.$store.state.signedIn) {
      this.$router.replace('/')
    } else {
      this.populateCases()
    }
  },
  methods: {
    populateCases() {
      this.$http.secured.get('/case')
        .then(response => {
          this.$store.commit('setCases', response.data.data)
        })
        .catch(error => { this.setError(error, 'Something went wrong') })
    },
    setError (error, text) {
      const e = (error.response && error.response.data && error.response.data.error) || text
      this.$store.commit('addAlert', { type: 'error', message: e})
    }
  },
  computed: {
    cases() {
      return this.$store.state.cases
    }
  }
}
</script>

<style lang="css">
.todos ul li i.fa.fa-trash-alt {
  visibility: hidden;
  margin-top: 5px;
}
.todos ul li:hover {
  background: #fcfcfc;
}
.todos ul li:hover i.fa.fa-trash-alt {
  visibility: visible;
}
</style>
