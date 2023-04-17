<template>
  <div>
    <Wizard :steps="steps" />
  </div>
</template>
<script>
import Wizard from '@/components/records/Wizard'
import { mapActions } from 'vuex'

export default {
  name: 'RecordForm',
  components: { Wizard },
  data() {
    return {
      schemaSetting: null,
      steps: null,
      recordId: null
    }
  },
  created() {
    this.recordId = this.$route.params.recordid || null
    if (this.recordId) {
      this.loadRecord(this.recordId)
      this.$store.commit('setCurrentRecordNew', false)
    } else {
      this.$store.commit('setCurrentRecordNew', true)
    }
    this.schemaSetting = this.createSettingsSchemaObject()
    this.steps = this.buildStepsWithSchema()
  },
  methods: {
    ...mapActions(['loadRecord']),
    createSettingsSchemaObject() {
      const settings = this.$store.getters.getSetting('settings_schema') ? JSON.parse(this.$store.getters.getSetting('settings_schema').value) : []
      let settingsObject = [];

      settings.forEach(s => {
        settingsObject.push(s)
      })

      return settingsObject
    },
    buildStepsWithSchema() {
      let steps = [ 
        { name: 'Start', link: { name: this.isNewRecord ? 'RecordNewStart' : 'RecordEditStart' }},
        { name: 'Meta', link: { name: this.isNewRecord ? 'RecordNewMeta' : 'RecordEditMeta' }},
        { name: 'Tat', link: { name: this.isNewRecord ? 'RecordNewCrime' : 'RecordEditCrime' }},
        { name: 'Opfer', link: { name: this.isNewRecord ? 'RecordNewVictim' : 'RecordEditVictim' }},
        { name: 'Täter', link: { name: this.isNewRecord ? 'RecordNewPerpetrator' : 'RecordEditPerpetrator' }}
      ];

      this.schemaSetting.forEach(s => {
        steps.push({name: s.name, link: {name: this.isNewRecord ? 'RecordNewEntity' : 'RecordEditEntity', 
                    params: { entityname: s.name }, 
                    query: { attributes: JSON.stringify(s.attributes) }}})
      })

      steps.push({name: 'Zusammenfassung', link: { name: this.isNewRecord ? 'RecordNewFinish' : 'RecordEditFinish'}});
      return steps
    }
  },
  computed: {
    isNewRecord() {
      return this.$store.getters.isCurrentRecordNew
    }
  }
}
</script>