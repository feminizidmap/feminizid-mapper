<template>
  <div class="border-start border-3 mb-4 ps-3">
    <template v-if="isEditedItem">
      <form @submit.prevent="updateItem()" class="col col-lg-6">
        <div class="">
          <label for="codelistitem-name"
                 class="visually-hidden">{{ $t('models.categoryItem.name') }}</label>
          <input type="text"
                 class="form-control"
                 id="codelistitem-name"
                 v-model="chItem.name">
          <br>
          <label for="codelistitem-description"
                 class="visually-hidden">{{ $t('models.categoryItem.description') }}</label>
          <textarea type="text"
                    class="form-control"
                    id="codelistitem-description"
                    v-model="chItem.description"></textarea>
        </div>
        <div class="mt-3" v-if="showIfAdmin()">
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
        <div class="col">
          <p class="h5">{{ item.name }}</p>
          <p class="mb-0">{{ item.description }}</p>
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
  props: ['item'],
  data() {
    return {
      isEditedItem: false,
      chItem: {}
    }
  },
  methods: {
    showIfAdmin() {
      return this.$store.getters.isAdmin
    },
    editItem() {
      this.chItem = Object.assign({}, this.item)
      this.isEditedItem = true
    },
    unEdit() {
      this.isEditedItem = false
    },
    updateItem() {
      this.$httpSecured.put(`/category_items/${this.item.id}`,
                             { category_item: this.chItem })
        .then((back) => {
          this.$store.commit('updateSingleCategoryItem', back.data)
          this.isEditedItem = false
        })
        .catch(error => this.$store.commit('addAlert', { type: 'error', message: error.response.data.error }))
    },
    removeItem() {
      this.$httpSecured.delete(`/category_items/${this.item.id}`)
        .then(() => {
             this.isEditedItem = false
             this.$store.commit('addAlert', { type: 'notice', message: this.$t('notice.deleteCatgoryItem') })
             this.$store.commit('removeSingleCategoryItem', this.item)
           })
           .catch(error => this.$store.commit('addAlert', { type: 'error', message: error.response.data.error }))
     }
   }
 }
</script>
