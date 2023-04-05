<template>
<div>
  <RecordFormWrapper title="Infos zum Opfer"
                   name="victimForm"
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
