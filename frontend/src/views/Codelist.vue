<template>
  <div class="codelists container-fluid">
    <div class="row my-3">
      <h1 class="display-3">Codelists</h1>
    </div>
    <div class="row">
      <div class="col-3">
        <nav class="list-group mb-4">
          <router-link :to="{ name: 'CodelistList', params: { codelistkey: list.id}}"
            v-for="list in lists"
            :key="list.id"
            :list="list"
            class="list-group-item">{{ list.name }}</router-link>
        </nav>

        <Form v-if="showIfAdmin()"></Form>
      </div>

      <div class="col">
        <router-view></router-view>



        <section v-for="list in lists" :key="list.id">
          <ItemForm v-if="showIfAdmin()" :codelist=list></ItemForm>

          <table class="table">
            <thead>
              <tr>
                <th>Identifier</th>
                <th>Name</th>
                <th>Description</th>
                <th>Language</th>
                <th>Edit</th>
                <th>Delete</th>
              </tr>
            </thead>
            <tbody>
              <template v-for="code in codes" :key="code.id" :code="code">
                <tr v-if="code.codelist_id == list.id">
                  <template v-if="code.id == editedCode.id">
                    <td><input type="text" v-model="editedCode.identifier"></td>
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
                    <td>{{ code.identifier }}</td>
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
              </template>
            </tbody>
          </table>

        </section>


      </div>
    </div>
  </div>
</template>

<script>
 import { sortBy } from 'lodash'
 import Form from '@/components/codelist/Form'
 import ItemForm from '@/components/codelistItem/Form'

 export default {
   name: 'UsersList',
   components: { Form, ItemForm },
   data () {
     return {
       error: '',
       editedCodelist: {},
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
       this.$http.secured.get('/codelist')
           .then(response => {
             this.$store.commit('setCodelists', response.data)
           })
           .catch(error => { this.setError(error, 'Something went wrong') })
       this.$http.secured.get('/codelist_items')
           .then(resp => {
             this.$store.commit('setCodelistItems', resp.data)
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
       this.$http.secured.put(`/codelist_items/${interrim.id}`,
                              { codelist_item: interrim })
           .then((back) => {
             this.$store.commit('updateSingleCodelist', back.data)
           })
           .catch(error => this.setError(error, 'Cannot update code'))
     },
     removeCode(code) {
       this.$http.secured.delete(`/codelist_items/${code.id}`)
           .then(() => {
             this.$store.commit('removeSingleCodelistItem', code)
           })
           .catch(error => this.setError(error, 'Cannot delete code'))
     },
   },
   computed: {
     lists() {
       let filtered = this.$store.state.codelists.filter(x => x.lang == this.$i18n.locale);
       //return groupBy(filtered, 'identifier')
       return sortBy(filtered, (o) => o.identifier)
     },
     codes() {
       let filtered = this.$store.state.codelistItems.filter(x => x.lang == this.$i18n.locale);
       return sortBy(filtered, (o) => o.identifier)
     }
   }
 }
</script>
