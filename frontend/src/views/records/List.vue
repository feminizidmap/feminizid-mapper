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
      <RecordsList :records="filteredRecords" v-if="filteredRecords">
        <RecordsItemComplex v-for="frecord in filteredRecords"
                          :key="frecord.id"
                          :item="frecord" />
      </RecordsList>
    </div>
    <div class="col col-lg-3"></div>
  </div>
</div>
</template>

<script>
import RecordsItemComplex from '@/components/records/ItemComplex'
import RecordsList from '@/components/records/List'

export default {
  name: 'RecordList',
  components: { RecordsList, RecordsItemComplex },
  computed: {
    filteredRecords() {
      return this.$store.state.records
    }
  }
}
</script>
