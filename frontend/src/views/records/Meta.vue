<template>
<div>
  <h3>Quellen</h3>
  <SourcesField />

  <div class="text-center border border-4  p-4 mt-5">
    <div class="d-flex justify-content-between">
      <router-link :to="{ name: 'RecordNewWizard' }" class="btn btn-primary">
        <i class="fas fa-arrow-circle-left"></i>
        Zurück zum Wizard</router-link>

      <router-link :to="{ name: 'RecordNewCrime' }" class="btn btn-primary">
        Infos zur Tat eintragen
        <i class="fas fa-arrow-circle-right"></i>
      </router-link>
    </div>
  </div>
</div>
</template>
<script>

import SourcesField from '@/components/records/SourcesField'

export default {
  name: 'RecordForm',
  components: { SourcesField },
  data() {
    return {

    }
  }
}
</script>
