<template>
<div class="codelists container-fluid">
  <header class="my-2 d-flex justify-content-between align-content-center">
    <h1 class="">{{ $t('layout.recordlist') }}</h1>
    <div>
      <router-link to="/records/new" class="btn btn-primary">Neuer Fall</router-link>
    </div>
  </header>
  <hr>
  <div class="row my-2">
    <div class="text-center">
    @todo search
    </div>
  </div>
  <hr>
  <div class="row my-2">
    <div class="col col-lg-3"></div>
    <div class="col-12 col-lg-6">
      <RecordsList :records="records" v-if="records">
        <RecordsItemComplex v-for="record in records"
                          :key="record.id"
                          :item="record" />
      </RecordsList>
    </div>
    <div class="col col-lg-3"></div>
  </div>
</div>
</template>

<script>
import RecordsItemComplex from '@/components/records/ItemComplex'
import RecordsList from '@/components/records/List'
import { mapState } from 'vuex'

export default {
  name: 'RecordList',
  components: { RecordsList, RecordsItemComplex },
  mounted () {
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
