<template>
<div>
  <RecordFormWrapper title="Infos zur Tat"
                   name="crimeForm"
                   :allowedLists="allowedCodelists"
                   :modelName="modelName">
    <label for="address" class="form-label">Adresse</label>
    <input type="url" class="form-control" id="address" placeholder="Str Hausnummer">

  </RecordFormWrapper>

  <div class="text-center border border-4  p-4 mt-5">
    <div class="d-flex justify-content-between">
      <router-link :to="{ name: 'RecordNewMeta' }" class="btn btn-primary">
        <i class="fas fa-arrow-circle-left"></i>
        Zurück zur Meta</router-link>

      <router-link :to="{ name: 'RecordNewVictim' }" class="btn btn-primary">
        Infos zum Opfer eintragen
        <i class="fas fa-arrow-circle-right"></i>
      </router-link>
    </div>
  </div>
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
