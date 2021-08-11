<template>
  <div class="codelist-form">
    <button type="button"
            class="btn btn-primary"
            data-bs-toggle="modal" :data-bs-target="'#' + modalId">
      <slot></slot></button>

    <div class="modal fade"
         :id="modalId" tabindex="-1"
         :aria-labelledby="modalLabel" aria-hidden="true">
      <div class="modal-dialog">
        <form @submit.prevent="sendCategory" class="modal-content">
          <div class="modal-header">
            <h4 :id="modalLabel" class="modal-title">
              {{ $t('prompts.newCategory') }}</h4>
            <button type="button" class="btn-close" data-bs-dismiss="modal"
                    :aria-label="$t('forms.close')"></button></div>

          <div class="modal-body">
            <div class="form-group mb-4">
              <label>{{ $t('models.category.name')}}
                <input class="form-control" required autocomplete="off"
                       v-model="newCat.name" /></label></div>
            <div class="form-group mb-4">
              <label>{{ $t('models.category.slug')}}
                <input class="form-control" required autocomplete="off"
                       v-model="newCat.slug" /></label></div>
            <div class="form-group mb-4">
              <label>{{ $t('models.category.description')}}
                <textarea class="form-control" autocomplete="off"
                       v-model="newCat.description"></textarea></label></div>
          </div>

          <div class="modal-footer">
            <button class="btn btn-primary" type="submit">
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
  props: [],
  data() {
    return {
      newCat: {}
    }
  },
  methods: {
    async sendCategory() {
      try {
        const response = await this.$http.secured.post('/categories', { category: this.newCat })
        this.$store.commit('addSingleCategory', response.data)
        window.bootstrap.Modal.getInstance(document.querySelector(`#${this.modalId}`)).hide()
        this.newCat = {}
      } catch(e) {
        this.$store.commit('addAlert', { type: 'error', message: e.response.data.error })

        this.setError(e, this.$t('errros.cannotCreateCodelist'))
      }
    }
  },
  computed: {
    modalId() {
      return 'newCategoryFormId'
    },
    modalLabel() {
      return 'newCategoryForm'
    }
  }
}
</script>
