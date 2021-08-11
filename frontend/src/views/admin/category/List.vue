<template>
  <div class="container-fluid">
    <div class="row">
      <div class="accordion accordion-flush" id="accordionCodelist">
        <section class="accordion-item"
             v-for="i in catList"
                 :key="i.id"
                 :list="i">

          <div class="accordion-header" :id="headerId(i)">
            <button class="accordion-button collapsed" type="button"
                    data-bs-toggle="collapse"
                    :data-bs-target="'#' + collapseId(i)" aria-expanded="false"
                    :aria-controls="collapseId(i)">
              <span v-if="i.type" class="badge bg-secondary me-2">{{ i.type }}</span>
              {{ i.name }}
            </button>
          </div>

          <div :id="collapseId(i)"
               class="accordion-collapse collapse"
               :aria-labelledby="headerId(i)"
               data-bs-parent="#accordionCodelist">
            <div class="accordion-body">
              <CategorySingle :category="i" />

              <div v-for="item in getItems(i)"
                   :key="item.id">
                {{item.name}}
              </div>

            </div>
          </div>

        </section>
      </div>
    </div>
    <div class="row mt-5">
      <CategoryForm>
        <i class="far fa-plus-square"></i><span class="ms-2">{{ $t('actions.new') }}</span>
      </CategoryForm>
    </div>
  </div>
</template>

<script>
import { sortBy, uniqBy } from 'lodash'
import CategorySingle from '@/components/categories/Single'
import CategoryForm from '@/components/categories/Form'

 export default {
   name: 'UsersList',
   components: { CategorySingle, CategoryForm },
   methods: {
     setError (error, text) {
       const e = (error.response && error.response.data && error.response.data.error) || text
       this.$store.commit('addAlert', { type: 'error', message: e})
     },
     showIfAdmin() {
       return this.$store.getters.isAdmin
     },
     headerId(list) {
       return `flush-heading-${list.id}`
     },
     collapseId(list) {
       return `flush-collapse-${list.id}`
     },
     getItems(cat) {
       return this.$store.getters.getItemsForCategory(cat)
     }
   },
   computed: {
     catList() {
       return sortBy(uniqBy(this.$store.state.categories, 'name'), 'name')
     }
   }
 }
</script>
