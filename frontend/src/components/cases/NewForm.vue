<template>
<div class="codelists container-fluid">
  <div class="row my-2">
    <h2>Neuen Fall hinzufügen</h2>
  </div>
  <div class="row my-2">

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
    }
  },
  created() {
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
