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
          <h2 class="h2">{{ $t('layout.records') }}</h2>
          <div>
          <router-link to="/records" class="btn btn-outline-primary me-2">Alle {{ $t('layout.records') }}</router-link>
          <router-link to="/records/new" class="btn btn-primary">Neuer Eintrag</router-link>
          </div>
        </div>
        <RecordsList :records="records">
          <RecordsItemSimple v-for="record in records"
                           :key="record.id"
                           :item="record" />
        </RecordsList>
        <hr>
      </section>
    </div>
  </div>
</div>
</template>

<script>
  import RecordsList from '@/components/records/List'
  import RecordsItemSimple from '@/components/records/ItemSimple'

export default {
  name: 'Dashboard',
  components: { RecordsList, RecordsItemSimple },
  data () {
    return {

    }
  },
  created () {
    if (!this.$store.state.signedIn) {
      this.$router.replace('/')
    } else {
      this.populateRecords()
    }
  },
  methods: {
    populateRecords() {
      this.$httpSecured.get('/records')
        .then(response => {
          this.$store.commit('setRecords', response.data)
        })
        .catch(error => { this.setError(error, 'Something went wrong') })
    },
    setError (error, text) {
      const e = (error.response && error.response.data && error.response.data.error) || text
      this.$store.commit('addAlert', { type: 'error', message: e})
    }
  },
  computed: {
    records() {
      return this.$store.state.records
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
