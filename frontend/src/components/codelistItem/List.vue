<template>
  <section>
    <ul class="list-group list-group-flushed mb-5" v-if="items.length">
      <li v-for="item in items"
          class="list-group-item"
          :key="item.id"
          :code="item">
        <template v-if="item.id == editedItem.id">
          <form @submit.prevent="updateItem()" class="row align-center  align-items-center">
            <p class="col col-1"><span class="badge rounded-pill bg-secondary">{{ item.identifier }}</span></p>
            <div class="col">
              <label for="codelistitem-name"
                     class="visually-hidden">{{ $t('models.codelistItem.name') }}</label>
              <input type="text"
                     class="form-control"
                     id="codelistitem-name"
                     v-model="editedItem.name">
            </div>
            <div class="col">
              <label for="codelistitem-description"
                     class="visually-hidden">{{ $t('models.codelistItem.description') }}</label>
              <textarea type="text"
                        class="form-control"
                        id="codelistitem-description"
                        v-model="editedItem.description"></textarea>
            </div>
            <p class="col col-1">{{ item.lang }}</p>
            <div class="col col-2 text-end">
              <button class="btn btn-outline-primary">
                <i class="fa fa-save"></i>
                <span class="visually-hidden">{{ $t('forms.save') }}</span></button>
            </div>
          </form>
        </template>

        <template v-else>
          <div class="row align-center align-items-center">
            <div class="col col-1"><span class="badge rounded-pill bg-secondary">{{ item.identifier }}</span></div>
            <div class="col">{{ item.name }}</div>
            <div class="col">{{ item.description }}</div>
            <div class="col col-1">{{ item.lang }}</div>
            <div class="col col-2 text-end">
              <button @click="editItem(item)" class="btn btn-outline-primary me-2">
                <i class="fa fa-edit"></i>
                <span class="visually-hidden">{{ $t('forms.edit') }}</span></button>
              <button @click="removeItem(item)" class="btn btn-outline-danger">
                <i class="fa fa-trash-alt"></i>
                <span class="visually-hidden">{{ $t('forms.delete') }}</span>
              </button>
            </div>
          </div>
        </template>
      </li>
    </ul>
    <p v-else>{{ $t('models.codelistItem.noSuch') }}</p>
  </section>
</template>
<script>
 import { sortBy } from 'lodash'

 export default {
   name: 'CodelistItemList',
   props: ['codelistId'],
   data () {
     return {
       editedItem: {}
     }
   },
   methods: {
     showIfAdmin() {
       return this.$store.getters.isAdmin
     },
     editItem(item) {
       this.editedItem = item
     },
     updateItem() {
       const interrim = this.editedItem
       this.editedItem = {}
       this.$http.secured.put(`/codelist_items/${interrim.id}`,
                              { codelist_item: interrim })
           .then((back) => {
             this.$store.commit('updateSingleCodelistItem', back.data)
           })
           .catch(error => this.setError(error, this.$t('error.cannotUpdateCodelistItem')))
     },
     removeItem(item) {
       this.$http.secured.delete(`/codelist_items/${item.id}`)
           .then(() => {
             this.$store.commit('addAlert', { type: 'notice', message: this.$t('notice.deleteCodelistItem') })
             this.$store.commit('removeSingleCodelistItem', item)
           })
           .catch(error => this.setError(error, this.$t('error.cannotDeleteCodelistItem')))
     },
     setError(error, text) {
       const e = (error.response && error.response.data && error.response.data.error) || text
       this.$store.commit('addAlert', { type: 'error', message: e})
     }
   },
   computed: {
     items() {
       return sortBy(this.$store.getters.getCodelistItemsByListId(this.codelistId), x => x.identifier)
     }
   }
 }
</script>
