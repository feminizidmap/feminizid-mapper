<template>
  <div class="codelistitem-form">
    <button type="button" class="btn btn-primary"
            data-bs-toggle="modal" :data-bs-target="'#' + modalId">
      <slot></slot>
    </button>

    <div class="modal fade"
         :id="modalId" tabindex="-1"
         :aria-labelledby="modalLabel" aria-hidden="true">
      <div class="modal-dialog">
        <form @submit.prevent="sendCodeItem" class="modal-content">

          <div class="modal-header">
            <h3 :id="modalLabel" class="modal-title">{{ $t('prompts.newCategoryItem') }}</h3>
            <button type="button" class="btn-close" data-bs-dismiss="modal"
                    :aria-label="$t('forms.close')"></button></div>

          <div class="modal-body">
            <div class="mb-2"><span class="badge bg-secondary me-2">{{ identifier }}</span></div>

            <div class="form-group mb-4">
              <label>{{ $t('models.categoryItem.name') }}
                <input class="form-control"
                       required
                       autocomplete="off"
                       v-model="newItem.name" /></label></div>
            <div class="form-group mb-4">
              <label>{{ $t('models.categoryItem.slug') }}
                <input class="form-control"
                       required
                       autocomplete="off"
                       v-model="newItem.slug" /></label></div>
            <div class="form-group mb-4">
              <label>{{ $t('models.categoryItem.description') }}
                <input class="form-control"
                       autocomplete="off"
                       v-model="newItem.description" /></label></div>
          </div>

          <div class="modal-footer">
            <button class="btn btn-primary me-2" type="submit">
              <i class="fa fa-save me-2"></i><span>{{ $t('forms.save') }}</span></button>
            <button class="btn btn-outline-secondary" data-bs-dismiss="modal"
                    :aria-label="$t('forms.cancel')" type="button">
              <i class="fa fa-ban me-2"></i><span>{{ $t('forms.cancel') }}</span></button>
          </div>
        </form>
      </div>
    </div>
  </div>
</template>
<script>
export default {
  name: 'Form',
  props: ['category'],
  data() {
    return {
      newItem: {}
    }
  },
  methods: {
    async sendCodeItem() {
      try {
        this.newItem.category_id = this.category.id
        const response = await this.$httpSecured.post('/category_items', { category_item: this.newItem })
        this.$store.commit('addSingleCategoryItem', response.data)
        window.bootstrap.Modal.getInstance(document.querySelector(`#${this.modalId}`)).hide()
        this.newItem = {}
      } catch(e) {
        this.$store.commit('addAlert', { type: 'error', message: e.response.data.error })
       }
     }
   },
   computed: {
     modalId() {
       return `categoryItemFormModal-${this.category.id}`
     },
     modalLabel() {
       return `categoryItemModalLabel-${this.category.id}`
     }
   }

 }
</script>
