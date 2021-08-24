<template>
<div class="entity-item">
  <div class="d-flex justify-content-between">
    <p class="fs-4">{{ entity.name }}</p>

    <button @click.prevent="" class="btn btn-outline-primary me-2">
      <i class="fa fa-edit"></i>
      <span class="visually-hidden">{{ $t('forms.edit') }}</span></button>
    <button @click.prevent="emitRmEntity" class="btn btn-outline-danger">
      <i class="fa fa-trash-alt"></i>
      <span class="visually-hidden">{{ $t('forms.delete') }}</span>
    </button>
  </div>
  <div>
    <ul v-if="entity.attributes"
        class="border-start border-4">
      <li
        v-for="(attr, i) in entity.attributes"
        :key="i"
        class="d-flex justify-content-between">
        <div>
          {{ attr.name }}
        </div>
        <button type="button"
                class="btn btn-outline-danger"
                @click.prevent="emitRmField(attr)">
          <i class="far fa-trash-alt"></i>
          Entfernen</button>
      </li>
    </ul>

    <div class="mt-3">
      <button type="button"
              class="btn btn-primary"
              @click.prevent="toggleAttributeForm"
              v-if="!showAttributeForm">
        <i class="far fa-plus-square"></i>
        Codelist-Feld hinzufügen</button>

      <form v-if="showAttributeForm"
            @submit.prevent="emitNewAttribute"
            class="border border-2 p-4 mt-3 mb-5">
        <select
          @change="updateNewAttribute"
          class="form-select" aria-label="Select">
          <option v-for="(item, i) in $store.state.codelists"
                  :key="i"
                  :value="item.id">{{ item.name }}</option>
        </select>
        <button type="submit"
                class="btn btn-outline-primary">
          <i class="far fa-save"></i>
          Speichern</button>
        <button type="button mt-5"
                class="btn btn-link link-danger"
                @click.prevent="toggleAttributeForm">
          <i class="far fa-times-circle"></i>
          Abbrechen</button>
      </form>

      <button type="button"
              class="btn btn-primary"
              @click.prevent="toggleFieldForm"
              v-if="!showFieldForm">
        <i class="far fa-plus-square"></i>
        Freifeld hinzufügen</button>

      <form v-if="showFieldForm"
            class="border border-2 p-4 mt-5 mb-3"
            @submit.prevent="emitNewField">
        <label>
          <span>Name</span>
          <input type="text" class="form-control" placeholder="Entity name"
                 @keyup="updateNewField"
                 :value="newField.name">
        </label>
        <label>
          <span>Slug</span>
          <input type="text" class="form-control" readonly
                 :value="newField.slug">
        </label>
        <button type="submit"
                class="btn btn-outline-primary">
          <i class="far fa-save"></i>
          Speichern</button>
        <button type="button mt-5"
                class="btn btn-link link-danger"
                @click.prevent="toggleFieldForm">
          <i class="far fa-times-circle"></i>
          Abbrechen</button>
      </form>
    </div>
  </div>
</div>
</template>
<script>
export default {
  name: 'EntityItem',
  props: { entity: Object },
  data() {
    return {
      showAttributeForm: false,
      showFieldForm: false,
      newField: {},
      newAttribute: {}
    }
  },
  methods: {
    toggleAttributeForm() {
      this.showAttributeForm = !this.showAttributeForm
      if (this.showAttributeForm === false) {
        this.newAttribute = {}
      }
    },
    toggleFieldForm() {
      this.showFieldForm = !this.showFieldForm
      if (this.showFieldForm === false) {
        this.newField = {}
      }
    },
    emitNewField() {
      let obj = { e: this.entity, field: this.newField }
      this.$emit('newField', obj)
      this.newField = {}
      this.showFieldForm = false
    },
    emitNewAttribute() {
      let obj = { e: this.entity, field: { slug: this.newAttribute,
                                           name: this.newAttribute}}
      this.$emit('newAttribute', obj)
      this.newAttribute = {}
      this.showAttributeForm = false
    },
    emitRmField(attr) {
      this.$emit('rmField', {e: this.entity, a: attr})
    },
    emitRmEntity() {
      this.$emit('rmEntity', this.entity)
    },
    updateNewField(ev) {
      this.newField.name = ev.target.value
      this.newField.slug = this.newField.name.toLowerCase().replaceAll(" ", "-")
    },
    updateNewAttribute(ev) {
      this.newAttribute = ev.target.value
    }
  }
}
</script>
