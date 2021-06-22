<template>
<div>
  <CaseFormWrapper title="Infos zum Täter"
                   name="crimeForm"
                   :allowedLists="allowedCodelists"
                   :modelName="modelName">
    <label for="address" class="form-label">Adresse</label>
    <input type="url" class="form-control" id="address" placeholder="Str Hausnummer">

  </CaseFormWrapper>

  <div class="text-center border border-4  p-4 mt-5">
    <div class="d-flex justify-content-between">
      <router-link :to="{ name: 'CaseNewVictim' }" class="btn btn-primary">
        <i class="fas fa-arrow-circle-left"></i>
        Zurück zum Opfer</router-link>

      <router-link :to="{ name: 'CaseNewFinish' }" class="btn btn-primary">
        Fall beenden
        <i class="fas fa-arrow-circle-right"></i>
      </router-link>
    </div>
  </div>
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
