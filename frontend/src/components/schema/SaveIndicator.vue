<template>
  <div v-if="isLoading" class="text-end">
    <div class="spinner-border" role="status">
      <span class="visually-hidden">{{ $t('actions.loading') }}</span>
    </div>
  </div>
  <div v-else>
    <div v-if="storeState" class="text-end">
      <span class="text-muted">{{ $t('layout.changes2Save') }}</span>
      <button @click.prevent="persistSchema" class="btn btn-outline-primary ms-3">
        <i class="fa fa-save"></i>
        <span class="visually-hidden">{{ $t('forms.save') }}</span></button>
    </div>
  </div>
</template>
<script>
export default {
  name: 'SchemaSave',
  props: { isLoading: Boolean },
  methods: {
    persistSchema() {
      this.$emit('persistSchema')
    }
  },
  computed: {
    storeState() {
      return this.$store.state.schemaHasChanged
    }
  }
}
</script>
