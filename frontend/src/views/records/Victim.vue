<template>
<div>
  <RecordFormWrapper title="Infos zum Opfer"
                   name="victimForm"
                   :allowedLists="allowedCodelists"
                   :modelName="modelName">
    <label for="address" class="form-label">Adresse</label>
    <input type="url" class="form-control" id="address" placeholder="Str Hausnummer">

  </RecordFormWrapper>

  <div class="text-center border border-4  p-4 mt-5">
    <div class="d-flex justify-content-between">
      <router-link :to="{ name: 'RecordNewCrime' }" class="btn btn-primary">
        <i class="fas fa-arrow-circle-left"></i>
        Zurück zur Tat</router-link>

      <router-link :to="{ name: 'RecordNewPerpetrator' }" class="btn btn-primary">
        Infos zum Täter eintragen
        <i class="fas fa-arrow-circle-right"></i>
      </router-link>
    </div>
  </div>
</div>
</template>
<script>
  import RecordFormWrapper from '@/components/records/RecordFormWrapper'

export default {
  name: 'RecordVictim',
  components: { RecordFormWrapper },
  data() {
    return {
      modelName: 'victim',
      allowedCodelists: [2, 3, 4, 11]
    }
  },
  methods: {
  }
}
</script>
