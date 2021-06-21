<template>
<div>
  <CaseFormWrapper title="Infos zur Tat"
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
  name: 'CaseCrime',
  components: { CaseFormWrapper },
  data() {
    return {
      modelName: 'crime',
      allowedCodelists: [8, 9]
    }
  }
}
</script>
