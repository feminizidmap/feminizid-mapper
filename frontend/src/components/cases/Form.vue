<template>
<div class="codelists container-fluid">
  <div class="row my-2">

  </div>
  <div class="row my-2">
    <h3>Metainformation</h3>
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
      //isNew: false
    }
  },
  created() {
    //this.isNew = this.fcase ? false : true;

  },
  computed: {
    identifier() {
      let d = new Date();
      return `${d.getFullYear()}-${d.getMonth()}-${ 0 }-${ 0 }`
    },
    isNew() {
      return this.fcase ? false : true;
    }
  },
  methods: {

  }
}
</script>
