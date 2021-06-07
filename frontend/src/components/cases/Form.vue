<template>
<div class="codelists container-fluid">
  <div class="row my-2">

  </div>
  <div class="row my-2">
    <h2 v-if="isNew">Neuen Fall hinzufügen</h2>
    <h2 v-else>Edit</h2>
  </div>
  <div class="row my-2">
    <div>
      <strong>Identifier:</strong>
      <span class="d-inline form-control form-control-lg user-select-all">{{ identifier }}</span>
      <br>
      <span>@todo explain what the identifier is/ does</span>
    </div>
  </div>
  <div class="row my-4">
    <h3>Quellen</h3>
    <SourcesField :ident="identifier" />
  </div>
</div>
</template>

<script>
import SourcesField from '@/components/cases/SourcesField'
//import CDate from '@/components/cases/Date'

export default {
  name: 'CaseSingle',
  components: { SourcesField },
  props: ['fcase'],
  data() {
    return {
      isNew: false
    }
  },
  created() {
    this.isNew = this.fcase ? false : true;

  },
  computed: {
    identifier() {
      let d = new Date();
      return `${d.getFullYear()}-${d.getMonth()}-${ 0 }-${ 0 }`
    }
  },
  methods: {

  }
}
</script>
