<template>
<div>
  <CaseFormWrapper title="Infos zum Täter"
                   name="crimeForm"
                   :allowedLists="allowedCodelists"
                   :modelName="modelName">
    <label for="address" class="form-label">Adresse</label>
    <input type="url" class="form-control" id="address" placeholder="Str Hausnummer">

  </CaseFormWrapper>
</div>
</template>
<script>
import CaseFormWrapper from '@/components/cases/CaseFormWrapper'

export default {
  name: 'CasePerp',
  components: { CaseFormWrapper },
  data() {
    return {
      modelName: 'perpetrator',
      allowedCodelists: [2, 3, 4, 6, 11, 12, 13, 14]
    }
  }
}
</script>
