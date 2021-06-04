<template>
<div class="codelists container-fluid">
  <div class="row my-2">
    <CasesList :cases="filteredCases">
      <CasesItemComplex v-for="fcase in filteredCases"
                       :key="fcase.id"
                       :item="fcase" />
    </CasesList>
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
