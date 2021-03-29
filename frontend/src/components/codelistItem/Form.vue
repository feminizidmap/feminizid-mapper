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
            <h3 :id="modalLabel" class="modal-title">{{ $t('prompts.newOption') }}</h3>
            <button type="button" class="btn-close" data-bs-dismiss="modal"
                    :aria-label="$t('forms.close')"></button></div>

          <div class="modal-body">
            <div class="mb-2"><span class="badge bg-secondary me-2">{{ identifier }}</span></div>

            <div class="form-group mb-4">
              <label>{{ $t('models.codelistItem.name') }}
                <input class="form-control"
                       required
                       autocomplete="off"
                       v-model="name" /></label></div>
            <div class="form-group mb-4">
              <label>{{ $t('models.codelistItem.description') }}
                <input class="form-control"
                       autocomplete="off"
                       v-model="description" /></label></div>
            <label>{{ $t('models.codelistItem.lang') }}
              <select v-model="lang" class="form-select">
                <option v-for="l in $i18n.availableLocales" :key="l" :value="l">{{l}}</option>
              </select></label>
          </div>

          <div class="modal-footer">
            <button class="btn btn-primary me-5" type="submit">
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
   props: ['codelistId', 'identifier'],
   data() {
     return {
       name: '',
       description: '',
       lang: ''
     }
   },
   methods: {
     async sendCodeItem() {
       try {
         const body = {
           codelist: this.codelistId,
           identifier: this.identifier,
           name: this.name.trim(),
           description: this.description.trim(),
           lang: this.lang
         }
         const response = await this.$http.secured.post('/codelist_items', { codelist_item: body })
         this.$store.commit('addToCodelistItems', response.data)
         window.bootstrap.Modal.getInstance(document.querySelector(`#${this.modalId}`)).hide()
         this.name = ''
         this.description = ''
         this.lang = ''
       } catch(e) {
         this.setError(e, 'Cannot create code item')
       }
     },
     setError(error, text) {
       const e = (error.response && error.response.data && error.response.data.error) || text
       this.$store.commit('addAlert', { type: 'error', message: e})
     },
   },
   computed: {
     modalId() {
       return `codelistItemFormModal-${this.identifier}`
     },
     modalLabel() {
       return `codelistItemModalLabel-${this.identifier}`
     }
   }

 }
</script>
