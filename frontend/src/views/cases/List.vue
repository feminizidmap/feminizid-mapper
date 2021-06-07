<template>
<div class="codelists container-fluid">
  <div class="row my-2">
    @todo search

  </div>
  <hr>
  <div class="row my-2">
    <div class="col-9">
      <CasesList :cases="filteredCases" v-if="filteredCases">
        <CasesItemComplex v-for="fcase in filteredCases"
                          :key="fcase.id"
                          :item="fcase" />
      </CasesList>
    </div>
    <aside class="col-3">
      <h3>Stats</h3>
      <p>Fälle insgesamt: {{ this.$store.state.cases.length }}</p>
    </aside>
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
