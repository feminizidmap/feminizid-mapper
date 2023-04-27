<template>
    <div class="accordion" :id="accName">
        <div v-for="(list, index) in lists" :key="list.id" class="accordion-item">
            <h3 class="accordion-header" :id="headingId(index)">
                <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" :data-bs-target="`#${collapseId(index)}`" aria-expanded="false" :aria-controls="`#${collapseId(index)}`">
                    {{ list.name }}
                </button>
            </h3>

            <div :id="collapseId(index)" class="accordion-collapse collapse" :aria-labelledby="`#${headingId(index)}`" :data-bs-parent="`#${accName}`">
                <div class="accordion-body">
                    <p v-if="list.description">{{ list.description}}</p>
                    // @todo make different components
                    <template v-if="list.type === 'category'">
                        <div class="form-check" v-for="item in categoryItems(list)"
                             :key="item.id">
                            <input class="form-check-input" type="radio" value="" :name="list.id" :id="item.id" @change="updateEntityValue(list.name, $event.target.value, list.type)">
                            <label class="form-check-label" :for="item.id">
                                {{item.name}}
                            </label>
                        </div>
                    </template>
                    <template v-else>
                        // @todo there will be special fields, like picking a location, nationality etc
                        <label :for="list.name" class="form-label">{{ list.name }}</label>
                        <input type="" class="form-control" :id="list.id" :value="entityValue(list.name, list.type)" @change="updateEntityValue(list.name, $event.target.value, list.type)" placeholder="">
                    </template>

                    <slot></slot>
                </div>
            </div>
        </div>
    </div>
</template>
<script>
 import { mapState, mapGetters, mapActions } from 'vuex'

 export default {
     name: "Accordion",
     props: ['lists', 'accName'],
     methods: {
         ...mapActions(['updateCurrentRecordProperty']),
         entityValue(name, type) {
             return this.getEntityValue(this.$route.params.entityname, name, type)
         },
         categoryItems(list) {
             return this.$store.getters.getItemsForCategory(list)
         },
         headingId(id) {
             return `heading-${id}`
         },
         collapseId(id) {
             return `collapse-${id}`
         },
         updateEntityValue(name, value, typ) {
             this.$emit('inputChange', name, value, typ)
         },
     },
     computed: {
         ...mapState(['currentRecord']),
         ...mapGetters(['getEntityValue']),
         currentEntities() {
             return this.currentRecord.entities ? this.currentRecord.entities : []
         },
     }
 }
</script>
