<template>
  <div class="codelists-list container-fluid">
    <CodelistSingle :codelistId="currentId"></CodelistSingle>
    <CodelistItemList :codelistId="currentId"></CodelistItemList>
    <CodelistItemForm v-if="showIfAdmin()" :codelistId="currentId"></CodelistItemForm>
  </div>
</template>
<script>
 import CodelistSingle from '@/components/codelist/Single'
 import CodelistItemList from '@/components/codelistItem/List'
 import CodelistItemForm from '@/components/codelistItem/Form'

 export default {
   name: 'CodelistSingleView',
   components: {
     CodelistSingle,
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
       return parseInt(this.$route.params.codelistkey, 10)
     }
   }
 }
</script>
