<template>
<div class="category-single row">
  <div class="col col-lg-6">
    <template v-if="isEditing">
      <form class="border border-2 p-3 mb-5 rounded" @submit.prevent="updateCategory">
        <input class="form-control"
               @blur="updateCategory"
               @keyup.enter="updateCategory"
               v-model="chCat.name"
               />
        <input class="form-control mt-3"
               @blur="updateCategory"
               @keyup.enter="updateCategory"
               v-model="chCat.description"
               />
        <div class="mt-3">
        <button type="submit" class="btn btn-outline-primary">
          <i class="fas fa-save"></i>
          <span class="visually-hidden">{{ $t('actions.save') }}</span>
        </button>
        <button type="button" class="btn btn-outline-secondary ms-2" @click.prevent="unEdit">
            <i class="fa fa-ban"></i>
            <span class="visually-hidden">{{ $t('forms.cancel') }}</span></button>
        </div>
      </form>
    </template>
    <template v-else>
      <h2 :title="category.slug">{{category.name}}</h2>
      <p class="lead">{{ category.description }}</p>
    </template>
  </div>
  <div class="col col-lg-6 text-end" v-if="!isEditing">
    <button v-if="showIfAdmin"
            @click="edit"
            class="btn btn-outline-primary me-2">
            <i class="fa fa-edit"></i>
            <span class="visually-hidden">{{ $t('forms.edit') }}</span></button>
    <button v-if="showIfAdmin"
            class="btn btn-outline-danger"
            @click="removeCategory">
      <i class="fas fa-trash-alt"></i>
      <span class="visually-hidden">{{ $t('actions.delete') }}</span>
    </button>
  </div>
</div>
</template>
<script>
export default {
  name: 'CategorySingle',
  props: ['category'],
  data () {
    return {
      isEditing: false,
      chCat: {}
    }
  },
  methods: {
    edit() {
      this.isEditing = true
      this.chCat = Object.assign({}, this.category)
    },
    unEdit() {
      this.isEditing = false
    },
    updateCategory() {
      this.$httpSecured.put(`/categories/${this.chCat.id}`,
                             { category: this.chCat })
        .then((back) => {
          this.isEditing = false
          this.$store.commit('updateSingleCategory', back.data)
        })
        .catch(error => this.$store.commit('addAlert', { type: 'error', message: error.message }))
    },
    removeCategory() {
      this.$httpSecured.delete(`/categories/${this.category.id}`)
        .then(() => {
          this.isEditing = false
          this.$store.commit('removeSingleCategory', this.category)
          this.$store.commit('addAlert', { type: 'notice', message: this.$t('notice.deleteCategory') })
        })
        .catch(error => this.$store.commit('addAlert', { type: 'error', message: error.message }))
     },
     showIfAdmin() {
       return this.$store.getters.isAdmin
     }
  }
 }
</script>
