<template>
<div class="codelists container-fluid">
  <div class="row my-2">
    <CasesList :cases="$store.state.cases" />
  </div>
</div>
</template>

<script>
import CasesList from '@/components/cases/List'

export default {
  name: 'CaseList',
  components: { CasesList }
}
</script>
