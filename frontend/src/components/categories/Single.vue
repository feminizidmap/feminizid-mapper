<template>
<div class="category-single row">
  <div class="col col-lg-6">
    <template v-if="isEditing">
      <form class="border border-2 p-3 mb-5 rounded" @submit.prevent="updateCategory">
        <input class="form-control"
               v-focus
               @blur="updateCategory"
               @keyup.enter="updateCategory"
               v-model="chCat.name"
               />
        <input class="form-control mt-3"
               v-focus
               @blur="updateCategory"
               @keyup.enter="updateCategory"
               v-model="chCat.description"
               />
        <button type="submit" class="btn btn-outline-primary mt-3">
          <i class="fas fa-save"></i>
          {{ $t('actions.save') }}
        </button>
      </form>
    </template>
    <template v-else>
      <h2 :title="category.slug"
          @dblclick="edit">{{category.name}}</h2>
      <p class="lead"
         @dblclick="edit">{{ category.description }}</p>
    </template>
  </div>
  <div class="col col-lg-6 text-end">
    <button v-if="showIfAdmin"
            class="btn btn-outline-danger"
            @click="removeCategory">
      <i class="fas fa-trash-alt"></i>
      {{ $t('actions.delete') }}
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
      this.$http.secured.put(`/categories/${this.chCat.id}`,
                             { category: this.chCat })
        .then((back) => {
          this.isEditing = false
          this.$store.commit('updateSingleCategory', back.data)
        })
        .catch(error => this.$store.commit('addAlert', { type: 'error', message: error.message }))
    },
    removeCategory() {
      this.$http.secured.delete(`/categories/${this.category.id}`)
        .then(() => {
          this.isEditing = false
          this.$store.commit('removeSingleCategory', this.category)
          this.$store.commit('addAlert', { type: 'notice', message: this.$t('notice.deleteCategory') })
        })
        .catch(error => this.$store.commit('addAlert', { type: 'error', message: error }))
     },
     showIfAdmin() {
       return this.$store.getters.isAdmin
     }
  },
  directives: {
    focus: {
      inserted(el) {
        console.log('hello', el)
        el.focus()
      }
    }
  }
 }
</script>
