<template>
  <div>
    <div class="alert alert-danger" v-if="error">{{ error }}</div>
    <h4>New Codelist</h4>
    <form @submit.prevent="sendCodelist">
      <div class="form-group mb-4">
        <label><span class="form-label">Code</span>
          <input class="form-control"
                 required
                 autofocus autocomplete="off"
                 v-model="code" />
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
  </div>
</template>
<script>
 export default {
   name: 'Form',
   data() {
     return {
       error: '',
       code: '',
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
         const body = { code: this.code.trim(),
                      name: this.name.trim(),
                      description: this.description.trim(),
                      lang: this.lang.trim()
         }
         const response = await this.$http.secured.post('/codelists', { codelist: body })
         this.$store.commit('addToCodelist', response.data)
         this.code = ''
         this.name = ''
         this.description = ''
         this.lang = ''
       } catch(e) {
         console.log(e)
         this.setError(e, 'Cannot create change')
       }
     },
     setError(error, text) {
       this.error = (error.response && error.response.data && error.response.data.error) || text
     }
   }
 }
</script>
