<template>
<div class="new-entity-item">
  <form>
          <label>
            <span>Entity name</span>
            <input type="text" class="form-control" placeholder="Entity name">
          </label>
          <label>
            <span>Slug</span>
            <input type="text" class="form-control" readonly>
          </label>
          <button type="button"
                  class="btn btn-outline-primary"
                  @click.prevent="saveEntityField">Speichern</button>
          <button type="button"
                  class="btn btn-outline-danger"
                  @click.prevent="rmEntityField">Entfernen</button>
        </form>
</div>
</template>
<script>
export default {
  name: 'NewEntityItem'
}
</script>
