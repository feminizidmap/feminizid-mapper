<template>
  <div class="codelists container-fluid">
    <div class="row">
      <Single v-for="list in lists"
              :key="list.id"
              :codelistId="list.id"></Single>
    </div>
    <Form v-if="showIfAdmin()"></Form>
  </div>
</template>

<script>
 import { sortBy } from 'lodash'
 import Single from '@/components/codelist/Single'
 import Form from '@/components/codelist/Form'

 export default {
   name: 'UsersList',
   components: { Form, Single },
   methods: {
     setError (error, text) {
       const e = (error.response && error.response.data && error.response.data.error) || text
       this.$store.commit('addAlert', { type: 'error', message: e})
     },
     showIfAdmin() {
       return this.$store.getters.isAdmin
     }
   },
   computed: {
     lists() {
       let filtered = this.$store.state.codelists.filter(x => x.lang == this.$i18n.locale)
       return sortBy(filtered, (o) => o.identifier)
     }
   }
 }
</script>
