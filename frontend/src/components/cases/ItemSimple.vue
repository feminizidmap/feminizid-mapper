<template>
<li class="list-group-item border-3 mb-2 case-item-simple">
  <h3 class="fw-bold h4 mt-2">{{ item.attributes.ident }}</h3>
  <CDate :item="item" />
</li>
</template>
<script>
  import CDate from '@/components/cases/Date'

export default {
  name: 'CaseItemSimple',
  props: ['item'],
  components: { CDate }
}
</script>

<style>
  .case-item-simple:hover {
    background-color: lightgrey
  }
</style>
