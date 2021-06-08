<template>
<div class="cases-list">
  <ul v-if="cases && cases.length"
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
  name: 'CasesList',
  props: ['cases']
}

</script>
