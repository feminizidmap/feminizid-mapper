<template>
<div class="new-entity-item">
  <button v-if="!showForm"
          type="btn"
          class="btn btn-primary"
          @click.prevent="toggleForm">
    <i class="far fa-plus-square"></i>
    Hinzufügen</button>

  <div v-if="showForm" class="border border-2 p-4">
    <form @submit.prevent="emitNewEntity" class="mb-4">
      <label>
        <span>Entity name</span>
        <input type="text" class="form-control" placeholder="Entity name"
               @keyup="updateEntityName" :value="newEntity.name">
      </label>
      <label>
        <span>Slug</span>
        <input type="text" class="form-control" readonly v-model="newEntity.slug">
      </label>
      <button type="submit"
              class="btn btn-outline-primary">
        <i class="far fa-save"></i>
        Speichern</button>

    </form>
    <button type="button mt-5"
            class="btn btn-link link-danger"
            @click.prevent="toggleForm">
      <i class="far fa-times-circle"></i>
      Abbrechen</button>
  </div>
</div>
</template>
<script>
export default {
  name: 'NewEntityItem',
  data() {
    return {
      showForm: false,
      newEntity: {}
    }
  },
  methods: {
    toggleForm() {
      this.showForm = !this.showForm
      if (this.showForm === false) {
        this.newEntity = {}
      }
    },
    updateEntityName(ev) {
      this.newEntity.name = ev.target.value
      this.newEntity.slug = this.newEntity.name.toLowerCase().replaceAll(" ", "-")
    },
    emitNewEntity() {
      this.$emit('newEntity', this.newEntity)
      this.showForm = false
      this.newEntity = {}
    }
  }
}
</script>
