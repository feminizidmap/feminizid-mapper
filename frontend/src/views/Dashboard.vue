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
import { mapState } from 'vuex'

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
      this.$store.dispatch('fetchRecords')
    }
  },
  computed: {
    ...mapState(['records'])
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
