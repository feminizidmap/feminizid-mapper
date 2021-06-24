<template>
<div class="entity-item">
  <div class="d-flex justify-content-between">
    <p class="fs-4">Opfer</p>

    <button type="button"
            class="btn btn-outline-danger"
            @click.prevent="rmEntityField">Entfernen</button>
  </div>
  <div>
    <ul class="border-start border-4">
      <li class="d-flex justify-content-between">
        <div>
          Bildungshintergrund
        </div>
        <button type="button"
                class="btn btn-outline-danger"
                @click.prevent="rmFieldField">Entfernen</button>
      </li>
      <li class="d-flex justify-content-between">
        <div>
          Staatsbürgerschaft
        </div>
        <button type="button"
                class="btn btn-outline-danger"
                @click.prevent="rmFieldField">Entfernen</button>
      </li>
    </ul>
    <div class="border border-2">
      <select class="form-select" aria-label="Select">
        <option v-for="(item, i) in $store.state.codelists"
                :key="i"
                :value="item.id">{{ item.name }}</option>
      </select>
      <button type="btn"
              class="btn btn-outline-primary"
              @click.prevent="addFieldField">Speichern</button>
      <button type="button"
              class="btn btn-outline-danger"
              @click.prevent="rmFieldField">Entfernen</button>
    </div>
    <button type="btn"
            class="btn btn-primary"
            @click.prevent="addFieldField">Codelist hinzufügen</button>
  </div>
  <div class="border border-2">
    <label>
      <span>Name</span>
      <input type="text" class="form-control" placeholder="Entity name">
    </label>
    <label>
      <span>Slug</span>
      <input type="text" class="form-control" readonly>
    </label>
    <button type="btn"
            class="btn btn-outline-primary"
            @click.prevent="addFieldField">Speichern</button>
    <button type="button"
            class="btn btn-outline-danger"
            @click.prevent="rmFieldField">Entfernen</button>
  </div>
  <button type="btn"
          class="btn btn-primary"
          @click.prevent="addFieldField">Freifeld hinzufügen</button>

</div>
</template>
<script>
export default {
  name: 'EntityItem'
}
</script>
