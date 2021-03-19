<template>
  <div class="admin codelists">
    <AppHeader></AppHeader>
    <div class="alert alert-danger" v-if="error">{{ error }}</div>
    <h2>Codelists</h2>

    <Form v-if="showIfAdmin()"></Form>

    <div v-for="list in lists" :key="list.id">
      <h3>{{ list[0].code }}</h3>
      <table class="table">
        <thead>
          <tr>
            <th>ID</th>
            <th>Code</th>
            <th>Name</th>
            <th>Description</th>
            <th>Language</th>
            <th>Edit</th>
            <th>Delete</th>
          </tr>
        </thead>
        <tbody>
          <tr v-for="code in list" :key="code.id" :code="code">
            <template v-if="code.id == editedCode.id">
              <th>{{ code.id }}</th>
              <td><input type="text" v-model="editedCode.code"></td>
              <td><input type="text" v-model="editedCode.name"></td>
              <td><input type="text" v-model="editedCode.description"></td>
              <td>{{ code.lang }}</td>
              <td>
                <button @click="updateCode()">
                  <i class="fa fa-save"></i>
                  <span class="visually-hidden">Save</span></button>
              </td>
              <td></td>
            </template>
            <template v-else>
              <th>{{ code.id }}</th>
              <td>{{ code.code }}</td>
              <td>{{ code.name }}</td>
              <td>{{ code.description }}</td>
              <td>{{ code.lang }}</td>
              <td>
                <button @click="editCode(code)">
                  <i class="fa fa-edit"></i>
                  <span class="visually-hidden">Edit</span></button>
              </td>
              <td>
                <button @click="removeCode(code)">
                  <i class="fa fa-trash-alt"></i>
                  <span class="visually-hidden">Delete</span>
                </button>
              </td>
            </template>
          </tr>
        </tbody>
      </table>

    </div>
  </div>
</template>

<script>
 import { groupBy } from 'lodash'
 import AppHeader from '@/layout/AppHeader'
 import Form from '@/components/codelist/Form'

 export default {
   name: 'UsersList',
   components: { AppHeader, Form },
   data () {
     return {
       error: '',
       editedCode: {}
     }
   },
   created () {
     if (this.$store.state.signedIn) {
       this.populateCodelists()
     } else {
       this.$router.replace('/')
     }
   },
   methods: {
     populateCodelists() {
       this.$http.secured.get('/codelists')
           .then(response => {
             this.$store.commit('setCodelists', response.data)
           })
           .catch(error => { this.setError(error, 'Something went wrong') })
     },
     setError (error, text) {
       this.error = (error.response && error.response.data && error.response.data.error) || text
     },
     showIfAdmin() {
       return this.$store.getters.isAdmin
     },
     editCode(code) {
       this.editedCode = code
     },
     updateCode() {
       const interrim = this.editedCode
       this.editedCode = {}
       this.$http.secured.put(`/codelists/${interrim.id}`,
                                { codelist: interrim })
              .then((back) => {
                this.$store.commit('updateCodelistItem', back.data)
              })
              .catch(error => this.setError(error, 'Cannot update code'))
     },
     removeCode(code) {
       this.$http.secured.delete(`/codelists/${code.id}`)
           .then(() => {
             this.$store.commit('removeCodelistItem', code)
           })
           .catch(error => this.setError(error, 'Cannot delete code'))
     }
   },
   computed: {
     lists() {
       let filtered = this.$store.state.codelists.filter(x => x.lang == this.$i18n.locale);
       return groupBy(filtered, 'code')
     }
   }
 }
</script>
