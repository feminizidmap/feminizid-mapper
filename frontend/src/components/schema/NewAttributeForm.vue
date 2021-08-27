<template>
<div class="attribute-form  border-end border-start border-bottom border-1">
  <form class="p-3">
    <div class="form-group my-3">
      <select class="form-select form-select-lg"
              v-model="newAttribute"
              :aria-label="$t('models.attribute.title')">
        <option v-for="category in availableCategories"
                :key="category.id"
                :value="category.id">
          {{ category.name}}</option>
      </select>
    </div>

    <div class="py-3 text-end">
      <button class="btn btn-primary" type="submit" @click.prevent="emitNewAttribute">
        <i class="fa fa-save me-2"></i><span>{{ $t('forms.save') }}</span></button>
      <button class="btn btn-outline-secondary ms-3" data-bs-dismiss="modal"
              :aria-label="$t('forms.cancel')" type="button">
        <i class="fa fa-ban me-2"></i><span>{{ $t('forms.cancel') }}</span></button>
    </div>
  </form>
</div>
</template>
<script>
export default {
  name: 'NewAttributeForm',
  props: { ident: Number },
  data() {
    return {
      newAttribute: {}
    }
  },
  methods: {
    emitNewAttribute() {
      this.$emit('addedNewAttribute', this.newAttribute)
      this.newAttribute = {}
    }
  },
  computed: {
    availableCategories() {
      return this.$store.state.categories
    }
  }
}
</script>
