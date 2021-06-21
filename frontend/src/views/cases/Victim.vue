<template>
<div>
  <CaseFormWrapper title="Infos zum Opfer"
                   name="victimForm"
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
  name: 'CaseVictim',
  components: { CaseFormWrapper },
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
