<template>
<div class="codelists container-fluid">
  <header class="my-2 d-flex justify-content-between align-content-center">
    <h1 class="">{{ $t('layout.caselist') }}</h1>
    <div>
      <router-link to="/cases/new" class="btn btn-primary">Neuer Fall</router-link>
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
      <CasesList :cases="filteredCases" v-if="filteredCases">
        <CasesItemComplex v-for="fcase in filteredCases"
                          :key="fcase.id"
                          :item="fcase" />
      </CasesList>
    </div>
    <div class="col col-lg-3"></div>
  </div>
</div>
</template>

<script>
import CasesItemComplex from '@/components/cases/ItemComplex'
import CasesList from '@/components/cases/List'

export default {
  name: 'CaseList',
  components: { CasesList, CasesItemComplex },
  computed: {
    filteredCases() {
      return this.$store.state.cases
    }
  }
}
</script>
