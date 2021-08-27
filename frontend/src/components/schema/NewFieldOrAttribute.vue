<template>
<div class="field-form">
  <button type="button"
          class="btn btn-primary"
          data-bs-toggle="modal" :data-bs-target="'#' + modalId">
    <slot></slot></button>

  <div class="modal fade"
       :id="modalId" tabindex="-1"
       :aria-labelledby="modalLabel" aria-hidden="true">
    <div class="modal-dialog">
      <div class="modal-content">
        <div class="modal-header">
          <h4 :id="modalLabel" class="modal-title">
            {{ $t('prompts.newFieldOrAttribute') }}</h4>
          <button type="button" class="btn-close" data-bs-dismiss="modal"
                  :aria-label="$t('forms.close')"></button></div>

        <div class="modal-body">
          <ul class="nav nav-tabs" :id="tabId" role="tablist">
            <li class="nav-item" role="presentation">
              <button class="nav-link active" :id="fieldTabId" data-bs-toggle="tab" :data-bs-target="'#'+ fieldId" type="button" role="tab" :aria-controls="fieldTabId" aria-selected="true">
                <i class="fas fa-tag me-1"></i>
                {{ $t('models.field.single') }}</button>
            </li>
            <li class="nav-item" role="presentation">
              <button class="nav-link" id="attrTabId" data-bs-toggle="tab" :data-bs-target="'#' + attrId" type="button" role="tab" :aria-controls="attrTabId" aria-selected="false">
                <i class="fas fa-tag me-1"></i>
                {{ $t('models.category.single') }}</button>
            </li>
        </ul>
        <div class="tab-content" :id="tabContentId">
          <div class="tab-pane show active" :id="fieldId" role="tabpanel" :aria-labelledby="fieldTabId">
            <FieldForm @addedNewField="emitNewField" />
          </div>
          <div class="tab-pane " :id="attrId" role="tabpanel" :aria-labelledby="attrTabId">
            <AttributeForm @addedNewAttribute="emitNewAttribute" :ident="ident" />
          </div>
        </div>
      </div>
      </div>
    </div>
  </div>
</div>
</template>
<script>
import AttributeForm from '@/components/schema/NewAttributeForm'
import FieldForm from '@/components/schema/NewFieldForm'

export default {
  name: 'NewFieldForm',
  props: { ident: Number },
  components: { AttributeForm, FieldForm },
  data() {
    return {

    }
  },
  methods: {
    emitNewField(field) {
      this.$emit('addedNewField', field)
      window.bootstrap.Modal.getInstance(document.querySelector(`#${this.modalId}`)).hide()
    },
    emitNewAttribute(field) {
      this.$emit('addedNewAttribute', field)
      window.bootstrap.Modal.getInstance(document.querySelector(`#${this.modalId}`)).hide()
    }
  },
  computed: {
    modalId() {
      return `newFieldFormId-${this.ident}`
    },
    modalLabel() {
      return `newFieldForm-${this.ident}`
    },
    tabId() {
      return `tab-${this.ident}`
    },
    tabContentId() {
      return `tabContent-${this.ident}`
    },
    fieldId() {
      return `fieldId-${this.ident}`
    },
    fieldTabId() {
      return `fieldTabId-${this.ident}`
    },
    attrId() {
      return `attrId-${this.ident}`
    },
    attrTabId() {
      return `attrTabId-${this.ident}`
    }
  }
}
</script>
