<template>
<div class="accordion" :id="accName">
  <div v-for="list in lists" :key="list.id" class="accordion-item">
    <h3 class="accordion-header" :id="headingId(list.id)">
      <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" :data-bs-target="`#${collapseId(list.id)}`" aria-expanded="false" :aria-controls="`#${collapseId(list.id)}`">
        {{ list.name }}
      </button>
    </h3>

    <div :id="collapseId(list.id)" class="accordion-collapse collapse" :aria-labelledby="`#${headingId(list.id)}`" :data-bs-parent="`#${accName}`">
      <div class="accordion-body">

        <p>{{ list.description}}</p>
        <div class="form-check" v-for="item in codelistItems(list.id)"
             :key="item.id">
          <input class="form-check-input" type="radio" value="" :name="list.id" :id="item.id">
          <label class="form-check-label" :for="item.id">
            {{item.name}}
          </label>
        </div>


        <slot></slot>


      </div>
    </div>
  </div>
</div>
</template>
<script>
export default {
  name: "Accordion",
  props: ['lists', 'accName'],
  methods: {
    codelistItems(listId) {
      return this.$store.getters.getCodelistItemsByListId(listId)
    },
    headingId(id) {
      return `heading-${id}`
    },
    collapseId(id) {
      return `collapse-${id}`
    }
  }
}
</script>
