<template>
<div class="field-item row align-items-center p-2  border-start border-3">
  <div class="col col-lg-10 row align-items-center">
    <div class="col col-6 col-lg-2 m-0">
      <p class="text-muted m-0">
        <i class="fas fa-tag me-1"></i>
        {{ field.type }}</p></div>
    <div class="col col-12 col-lg-10">
      <h6 class="m-0  fw-bold">
        <span class="">{{ field.name }}</span>
        <span class="ms-3 badge bg-info"
              v-if="field.feature">
          {{ field.feature}}</span>
      </h6>
    </div>
  </div>

  <div class="col col-2 text-end">
    <button
      v-if="showIfAdmin()"
      @click.prevent="emitRmField"
      class="btn btn-outline-danger">
      <i class="fa fa-trash-alt"></i>
      <span class="visually-hidden">{{ $t('forms.delete') }}</span>
    </button>
  </div>
</div>

</template>
<script>
export default {
  name: 'FieldItem',
  props: { field: Object },
  methods: {
    emitRmField() {
      this.$emit('rmField', this.field)
    },
    showIfAdmin() {
      return this.$store.getters.isAdmin
    },
  }
}
</script>

<style>
</style>
