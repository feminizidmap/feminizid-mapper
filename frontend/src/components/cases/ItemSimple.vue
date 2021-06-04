<template>
<li class="list-group-item">
  <span class=""><strong>{{ item.attributes.ident }}</strong></span><br>
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
