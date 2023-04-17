<template>
<div>
  <RecordFormWrapper title="Infos zur Tat"
                   name="crimeForm"
                   :allowedLists="allowedCodelists"
                   :modelName="modelName">
    <label for="address" class="form-label">Adresse</label>
    <input type="url" class="form-control" id="address" v-model="currentRecord.address" placeholder="Str Hausnummer">

  </RecordFormWrapper>
</div>
</template>
<script>
import RecordFormWrapper from '@/components/records/RecordFormWrapper'
import { mapState } from 'vuex'

export default {
  name: 'RecordCrime',
  components: { RecordFormWrapper },
  data() {
    return {
      modelName: 'crime',
      allowedCodelists: [8, 9],
    }
  },
  computed: {
    ...mapState(['currentRecord']),
  },
}
</script>
