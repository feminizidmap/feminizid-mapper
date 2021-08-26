<template>
<div class="attribute-form">
  <button type="button"
          class="btn btn-primary"
          data-bs-toggle="modal" :data-bs-target="'#' + modalId">
    <slot></slot></button>

  <div class="modal fade"
       :id="modalId" tabindex="-1"
       :aria-labelledby="modalLabel" aria-hidden="true">
    <div class="modal-dialog">
      <form @submit.prevent="sendCategory" class="modal-content">
        <div class="modal-header">
          <h4 :id="modalLabel" class="modal-title">
            {{ $t('prompts.addCategory') }}</h4>
          <button type="button" class="btn-close" data-bs-dismiss="modal"
                  :aria-label="$t('forms.close')"></button></div>

        <div class="modal-body">
          <div class="form-group mb-4">
            <select class="form-select form-select-lg"
                    v-model="newAttribute"
                    :aria-label="$t('models.attribute.title')">
                <option v-for="category in availableCategories"
                        :key="category.id"
                        :value="category.id">
                  {{ category.name}}</option>
              </select></div>
        </div>

        <div class="modal-footer">
          <button class="btn btn-primary" type="submit" @click.prevent="emitNewAttribute">
            <i class="fa fa-save me-2"></i><span>{{ $t('forms.save') }}</span></button>
          <button class="btn btn-outline-secondary" data-bs-dismiss="modal"
                  :aria-label="$t('forms.cancel')" type="button">
            <i class="fa fa-ban me-2"></i><span>{{ $t('forms.cancel') }}</span></button>
        </div>
      </form>
    </div>
  </div>
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
      window.bootstrap.Modal.getInstance(document.querySelector(`#${this.modalId}`)).hide()
      this.newAttribute = {}
    }
  },
  computed: {
    modalId() {
      return `newAttributeFormId-${this.ident}`
    },
    modalLabel() {
      return `newAttributeForm-${this.ident}`
    },
    availableCategories() {
      return this.$store.state.categories
    }
  }
}
</script>
