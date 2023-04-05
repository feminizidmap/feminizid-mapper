<template>
<div>
  <RecordFormWrapper title="Infos zum Täter"
                   name="crimeForm"
                   :allowedLists="allowedCodelists"
                   :modelName="modelName">
    <label for="address" class="form-label">Adresse</label>
    <input type="url" class="form-control" id="address" placeholder="Str Hausnummer">

  </RecordFormWrapper>
</div>
</template>
<script>
import RecordFormWrapper from '@/components/records/RecordFormWrapper'

export default {
  name: 'RecordPerp',
  components: { RecordFormWrapper },
  data() {
    return {
      modelName: 'perpetrator',
      allowedCodelists: [2, 3, 4, 6, 11, 12, 13, 14]
    }
  }
}
</script>
