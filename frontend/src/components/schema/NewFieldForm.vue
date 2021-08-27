<template>
<div class="field-form border-end border-start border-bottom border-1">
  <form class="p-3">
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
      </select></label>
    </div>

    <div class="py-3 text-end">
      <button class="btn btn-primary" type="submit" @click.prevent="emitNewField">
        <i class="fa fa-save me-2"></i><span>{{ $t('forms.save') }}</span></button>
      <button class="btn btn-outline-secondary ms-3" data-bs-dismiss="modal"
              :aria-label="$t('forms.cancel')" type="button">
        <i class="fa fa-ban me-2"></i><span>{{ $t('forms.cancel') }}</span></button>
    </div>
  </form>
</div>
</template>
<script>
import {slugify} from '@/util'
export default {
  name: 'NewFieldForm',
  data() {
    return {
      newField: {}
    }
  },
  methods: {
    emitNewField() {
      this.$emit('addedNewField', this.newField)
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
    fieldFeatures() {
      return JSON.parse(this.$store.getters.getSetting('settings_features').value)
    }
  }
}
</script>
