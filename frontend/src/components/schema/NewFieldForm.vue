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
      <form @submit.prevent="sendCategory" class="modal-content">
        <div class="modal-header">
          <h4 :id="modalLabel" class="modal-title">
            {{ $t('prompts.newField') }}</h4>
          <button type="button" class="btn-close" data-bs-dismiss="modal"
                  :aria-label="$t('forms.close')"></button></div>

        <div class="modal-body">
          <div class="form-group mb-4">
            <label>{{ $t('models.field.name')}}
              <input class="form-control" required autocomplete="off"
                     v-model="newField.name" /></label></div>
          <div class="form-group mb-4">
            <label>{{ $t('models.field.key')}}
              <input class="form-control" required autocomplete="off"
                     v-model="newField.key" readonly /></label></div>
          <div class="form-group mb-4">
            <label>{{ $t('models.field.feature')}}
              <select class="form-select" v-model="newField.feature">
                <option selected>{{ $t('models.field.none') }}</option>
                <option v-for="feature in fieldFeatures" :key="feature.slug">
                  {{ feature.name}}</option>
              </select></label></div>
        </div>

        <div class="modal-footer">
          <button class="btn btn-primary" type="submit" @click.prevent="emitNewField">
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
  import {slugify} from '@/util'
export default {
  name: 'NewFieldForm',
  props: { ident: Number },
  data() {
    return {
      newField: {}
    }
  },
  methods: {
    emitNewField() {
      this.$emit('addedNewField', this.newField)
      window.bootstrap.Modal.getInstance(document.querySelector(`#${this.modalId}`)).hide()
      this.newField = {}
    }
  },
  watch: {
    'newField.name': {
      handler(ev) {
        this.newField.key = slugify(ev)
      }
    }
  },
  computed: {
    modalId() {
      return `newFieldFormId-${this.ident}`
    },
    modalLabel() {
      return `newFieldForm-${this.ident}`
    },
    fieldFeatures() {
      return JSON.parse(this.$store.getters.getSetting('settings_features').value)
    }
  }
}
</script>
