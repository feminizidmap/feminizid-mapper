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
import SourcesField from '@/components/records/SourcesField'
//import CDate from '@/components/records/Date'

export default {
  name: 'RecordSingle',
  components: { SourcesField },
  props: ['record'],
  data() {
    return {
      //isNew: false
    }
  },
  created() {
    //this.isNew = this.record ? false : true;

  },
  computed: {
    identifier() {
      let d = new Date();
      return `${d.getFullYear()}-${d.getMonth()}-${ 0 }-${ 0 }`
    },
    isNew() {
      return this.record ? false : true;
    }
  },
  methods: {

  }
}
</script>
