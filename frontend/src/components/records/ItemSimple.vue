<template>
<li class="list-group-item border-3 mb-2 record-item-simple">
  <h3 class="fw-bold h4 mt-2">{{ item.identifier }}</h3>
  <CDate :item="item" />
</li>
</template>
<script>
  import CDate from '@/components/records/Date'

export default {
  name: 'RecordItemSimple',
  props: ['item'],
  components: { CDate }
}
</script>

<style>
  .record-item-simple:hover {
    background-color: lightgrey
  }
</style>
