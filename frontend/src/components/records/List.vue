<template>
<div class="records-list">
  <ul v-if="records && records.length"
      class="list-group">
    <slot></slot>
  </ul>
  <div v-else class="alert alert-info" role="alert">
    Nothing here yet
  </div>
</div>
</template>
<script>
export default {
  name: 'RecordsList',
  props: ['records']
}

</script>
