<template>
<div>
  <RecordFormWrapper title="Infos zur Tat"
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
  name: 'RecordCrime',
  components: { RecordFormWrapper },
  data() {
    return {
      modelName: 'crime',
      allowedCodelists: [8, 9]
    }
  }
}
</script>
