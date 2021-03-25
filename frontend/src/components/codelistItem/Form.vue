<template>
  <div class>
    <template v-if="showForm">
      <form @submit.prevent="sendCodeItem" class="border p-3">
        <h3 class="display-6 mb-4">{{ $t('prompts.newOption') }}</h3>
        <div class="form-group mb-4">
          <label><span class="form-label">{{ $t('models.codelistItem.identifier') }}</span>
            <input class="form-control"
                   required
                   autofocus autocomplete="off"
                   v-model="identifier" />
          </label>
        </div>
        <div class="form-group mb-4">
          <label>{{ $t('models.codelistItem.name') }}
            <input class="form-control"
                   required
                   autocomplete="off"
                   v-model="name" />
          </label>
        </div>
        <div class="form-group mb-4">
          <label>{{ $t('models.codelistItem.description') }}
            <input class="form-control"
                   autocomplete="off"
                   v-model="description" />
          </label>
        </div>
        <div class="form-group mb-4">
          <label>{{ $t('models.codelistItem.lang') }}
            <select v-model="lang" class="form-select">
              <option v-for="l in $i18n.availableLocales" :key="l" :value="l">{{l}}</option>
            </select>
          </label>
        </div>
        <div>
          <button class="btn btn-primary me-5" type="submit">
            <i class="fas fa-plus"></i>
            {{ $t('forms.create') }}</button>
          <button type="button" class="btn btn-link" @click="toggleForm">
            <i class="fas fa-ban"></i>
            {{ $t('forms.cancel') }}</button>
        </div>
      </form>
    </template>
    <template v-else>
      <button type="button" class="btn btn-outline-primary mb-4" @click="toggleForm">
        <i class="fas fa-plus"></i> {{ $t('forms.create') }}
      </button>
    </template>
  </div>
</template>
<script>
 export default {
   name: 'Form',
   props: ['codelistId'],
   data() {
     return {
       showForm: false,
       identifier: '',
       name: '',
       description: '',
       lang: ''
     }
   },
   created() {
   },
   methods: {
     async sendCodeItem() {
       console.log(this.lang)
       try {
         const body = {
           codelist: this.codelistId,
           identifier: this.identifier.trim(),
           name: this.name.trim(),
           description: this.description.trim(),
           lang: this.lang
         }
         const response = await this.$http.secured.post('/codelist_items', { codelist_item: body })
         this.$store.commit('addToCodelistItems', response.data)
         this.identifier = ''
         this.name = ''
         this.description = ''
         this.lang = ''
         this.toggleForm()
       } catch(e) {
         console.log(e)
         this.setError(e, 'Cannot create code item')
       }
     },
     setError(error, text) {
       const e = (error.response && error.response.data && error.response.data.error) || text
       this.$store.commit('addAlert', { type: 'error', message: e})
     },
     toggleForm() {
       this.showForm = !this.showForm
     }
   }
 }
</script>
