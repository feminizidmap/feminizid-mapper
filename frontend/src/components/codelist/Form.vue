<template>
  <div>
    <div class="alert alert-danger" v-if="error">{{ error }}</div>
    <button type="button" class="btn btn-primary mb-4" @click="toggleForm">Add new codelist</button>
    <template v-if="showForm">
      <h4>New Codelist</h4>
      <form @submit.prevent="sendCodelist" class="border p-3 m-3">
        <div class="form-group mb-4">
          <label><span class="form-label">Identifier</span>
            <input class="form-control"
                   required
                   autofocus autocomplete="off"
                   v-model="identifier" />
          </label>
        </div>
        <div class="form-group mb-4">
          <label>Name
            <input class="form-control"
                   required
                   autocomplete="off"
                   v-model="name" />
          </label>
        </div>
        <div class="form-group mb-4">
          <label>Description
            <input class="form-control"
                   autocomplete="off"
                   v-model="description" />
          </label>
        </div>
        <div class="form-group mb-4">
          <label>Language
            <input class="form-control"
                   required
                   autocomplete="off"
                   v-model="lang" />
          </label>
        </div>
        <button class="btn btn-primary" type="submit">Create</button>
      </form>
    </template>
  </div>
</template>
<script>
 export default {
   name: 'Form',
   data() {
     return {
       error: '',
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
     async sendCodelist() {
       try {
         const body = { identifier: this.identifier.trim(),
                      name: this.name.trim(),
                      description: this.description.trim(),
                      lang: this.lang.trim()
         }
         const response = await this.$http.secured.post('/codelist', { codelist: body })
         this.$store.commit('addToCodelist', response.data)
         this.identifier = ''
         this.name = ''
         this.description = ''
         this.lang = ''
       } catch(e) {
         console.log(e)
         this.setError(e, 'Cannot create coelist')
       }
     },
     setError(error, text) {
       this.error = (error.response && error.response.data && error.response.data.error) || text
     },
     toggleForm() {
       this.showForm = !this.showForm
     }
   }
 }
</script>
