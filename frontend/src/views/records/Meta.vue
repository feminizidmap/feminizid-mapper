<template>
  <div>
    <h3>Quellen</h3>
    <SourcesField :sources="currentSources" />
  </div>
</template>

<script>
import SourcesField from '@/components/records/SourcesField'
import { mapState } from 'vuex'

export default {
  name: 'RecordForm',
  components: { SourcesField },
  data() {
    return {

    }
  },
  computed: {
    ...mapState(['currentRecord']),
    currentSources() {
      return this.currentRecord ? this.currentRecord.sources : []
    }
  }
}
</script>
