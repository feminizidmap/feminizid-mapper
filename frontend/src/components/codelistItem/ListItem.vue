<template>
  <div>
    <template v-if="isEditedItem">
      <form @submit.prevent="updateItem()" class="row align-center  align-items-center">
        <p class="col col-1"><span class="badge rounded-pill bg-secondary">{{ item.lang }}</span></p>
        <div class="col">
          <label for="codelistitem-name"
                 class="visually-hidden">{{ $t('models.codelistItem.name') }}</label>
          <input type="text"
                 class="form-control"
                 id="codelistitem-name"
                 v-model="item.name">
        </div>
        <div class="col">
          <label for="codelistitem-description"
                 class="visually-hidden">{{ $t('models.codelistItem.description') }}</label>
          <textarea type="text"
                    class="form-control"
                    id="codelistitem-description"
                    v-model="item.description"></textarea>
        </div>
        <div class="col col-2 text-end" v-if="showIfAdmin()">
          <button type="submit" class="btn btn-outline-primary me-2">
            <i class="fa fa-save"></i>
            <span class="visually-hidden">{{ $t('forms.save') }}</span></button>
          <button type="button" class="btn btn-outline-secondary" @click.prevent="unEdit()">
            <i class="fa fa-ban"></i>
            <span class="visually-hidden">{{ $t('forms.cancel') }}</span></button>
        </div>
      </form>
    </template>

    <template v-else>
      <div class="row align-center align-items-center">
        <div class="col col-1"><span class="badge bg-secondary">{{ item.lang }}</span></div>
        <div class="col">
          <p class="h5">{{ item.name }}</p>
          <p>{{ item.description }}</p>
        </div>
        <div class="col col-2 text-end" v-if="showIfAdmin()">
          <button @click="editItem()" class="btn btn-outline-primary me-2">
            <i class="fa fa-edit"></i>
            <span class="visually-hidden">{{ $t('forms.edit') }}</span></button>
          <button @click="removeItem()" class="btn btn-outline-danger">
            <i class="fa fa-trash-alt"></i>
            <span class="visually-hidden">{{ $t('forms.delete') }}</span>
          </button>
        </div>
      </div>
    </template>
  </div>
</template>
<script>
 export default {
   name: 'ListItem',
   props: ['itemId'],
   data() {
     return {
       isEditedItem: false
     }
   },
   methods: {
     showIfAdmin() {
       return this.$store.getters.isAdmin
     },
     editItem() {
       this.isEditedItem = true
     },
     unEdit() {
       this.isEditedItem = false
     },
     updateItem() {
       this.$http.secured.put(`/codelist_items/${this.itemId}`,
                              { codelist_item: this.item })
           .then((back) => {
             this.$store.commit('updateSingleCodelistItem', back.data)
             this.isEditedItem = false
           })
           .catch(error => this.setError(error, this.$t('error.cannotUpdateCodelistItem')))
     },
     removeItem() {
       this.$http.secured.delete(`/codelist_items/${this.itemId}`)
           .then(() => {
             this.isEditedItem = false
             this.$store.commit('addAlert', { type: 'notice', message: this.$t('notice.deleteCodelistItem') })
             this.$store.commit('removeSingleCodelistItem', this.item)
           })
           .catch(error => this.setError(error, this.$t('error.cannotDeleteCodelistItem')))
     },
     setError(error, text) {
       const e = (error.response && error.response.data && error.response.data.error) || text
       this.$store.commit('addAlert', { type: 'error', message: e})
     }
   },
   computed: {
     item() {
       return this.$store.getters.getCodelistItemById(this.itemId)
     }
   }
 }
</script>
