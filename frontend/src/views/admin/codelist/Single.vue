<template>
  <div class="codelists-list container-fluid">
    <div class="row">
      <h2 class="h3">{{ codelist.name }}</h2>
      <p class="lead">{{ codelist.description }}</p>
    </div>

    <CodelistItemList :codelistId="currentId"></CodelistItemList>

    <CodelistItemForm v-if="showIfAdmin()"
                      :codelistId="currentId"
                      :identifier="identListCount + 1">
      <i class="fas fa-plus"></i> {{ $t('forms.create') }}
    </CodelistItemForm>
  </div>
</template>
<script>
 import { uniqBy } from 'lodash'
 import CodelistItemList from '@/components/codelistItem/List'
 import CodelistItemForm from '@/components/codelistItem/Form'

 export default {
   name: 'CodelistSingleView',
   components: {
     CodelistItemList,
     CodelistItemForm
   },
   data () {
     return {
     }
   },
   created () {

   },
   methods: {
     showIfAdmin() {
       return this.$store.getters.isAdmin
     },
   },
   computed: {
     currentId() {
       return this.$route.params.codelistkey
     },
     codelist() {
       return this.$store.getters.getCodelistById(this.currentId)
     },
     identListCount() {
       return uniqBy(this.$store.getters.getCodelistItemsByListId(this.currentId), 'identifier').length
     }
   }
 }
</script>
