<template>
  <div>
    <Wizard :steps="steps" />
  </div>
</template>
<script>
import Wizard from '@/components/records/Wizard'

export default {
  name: 'RecordNewForm',
  components: { Wizard },
  data() {
    return {
      schemaSetting: null,
      steps: null
    }
  },
  created() {
    this.schemaSetting = this.createSettingsSchemaObject(),
    this.steps = this.buildStepsWithSchema()
  },
  methods: {
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
        { name: 'Start', link: { name: 'RecordNewStart' }},
        { name: 'Meta', link: { name: 'RecordNewMeta' }},
        { name: 'Tat', link: { name: 'RecordNewCrime' }},
        { name: 'Opfer', link: { name: 'RecordNewVictim' }},
        { name: 'Täter', link: { name: 'RecordNewPerpetrator' }}
      ];

      this.schemaSetting.forEach(s => {
        steps.push({name: s.name, link: {name: 'RecordNewEntity', 
                    params: { entityname: s.name }, 
                    query: { attributes: JSON.stringify(s.attributes) }}})
      })

      steps.push({ name: 'Zusammenfassung', link: { name: 'RecordNewFinish'}});
      return steps
    }
  }
}
</script>