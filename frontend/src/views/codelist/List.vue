<template>
  <div class="codelists-list container-fluid">
    <header v-if="codelist" class="row mb-5">
      <template v-if="isEditingCodelist">
        <form  @submit.prevent="updateCodelist()" class="row">
          <div class="col">
            <label for="codelist-name" class="visually-hidden">{{ $t('models.codelist.name') }}</label>
            <input type="text"
                   v-model="codelist.name"
                   id="codelist-name"
                   class="form-control form-control-lg mb-1"><br>
            <label for="codelist-description" class="visually-hidden">{{ $t('models.codelist.description') }}</label>
            <textarea v-model="codelist.description"
                      id="codelist-description"
                      class="lead form-control"></textarea>
          </div>
          <div class="col col-sm-2 text-end">
            <button type="submit" class="btn btn-outline-primary">
              <i class="fa fa-save"></i>
              <span class="visually-hidden">{{ $t('forms.save') }}</span></button>
          </div>
        </form>
      </template>
      <template v-else>
        <div class="col">
          <h2 class="display-4">{{ codelist.name }}</h2>
          <p class="lead">{{ codelist.description }}</p>
        </div>
        <div class="col col-sm-2 text-end">
          <button @click="editCodelist()" class="btn btn-outline-primary me-3">
            <i class="fa fa-edit"></i>
            <span class="visually-hidden">{{ $t('forms.edit') }}</span></button>
          <button @click="removeCodelist()" class="btn btn-outline-danger">
            <i class="fa fa-trash-alt"></i>
            <span class="visually-hidden">{{ $t('forms.delete') }}</span>
          </button>
        </div>
      </template>
    </header>
    <div v-else>
      <p>{{ $t('models.codelist.noSuch') }}</p>
    </div>
  </div>
</template>
<script>
 export default {
   name: 'CodelistList',
   data () {
     return {
       isEditingCodelist: false,
       editedCodelist: {},
     }
   },
   created () {

   },
   methods: {
     editCodelist() {
       this.isEditingCodelist = true
     },
     updateCodelist() {
       this.$http.secured.put(`/codelist/${this.codelist.id}`,
                              { codelist: this.codelist })
           .then((back) => {
             this.isEditingCodelist = false
             this.$store.commit('updateSingleCodelist', back.data)
           })
           .catch(error => this.setError(error, this.$t('error.cannotUpdateCodelist')))
     },
     removeCodelist() {
       this.$http.secured.delete(`/codelist/${this.codelist.id}`)
           .then(() => {
             this.isEditingCodelist = true
             this.$store.commit('removeSingleCodelist', this.codelist.id)
             this.$store.commit('addAlert', { type: 'notice', message: this.$t('notice.deleteCodelist') })
             this.$router.replace('/codelists')
           })
           .catch(error => this.setError(error, this.$t('error.cannotDeleteCodelist')))
     },
     setError(error, text) {
       const e = (error.response && error.response.data && error.response.data.error) || text
       this.$store.commit('addAlert', { type: 'error', message: e})
     }
   },
   computed: {
     codelist() {
       const id = parseInt(this.$route.params.codelistkey, 10)
       return this.$store.getters.getCodelistById(id)
     }
   }
 }
</script>
