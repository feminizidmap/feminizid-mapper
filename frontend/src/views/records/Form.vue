<template>
  <div>
    <WizardPanel :steps="steps" />
    <WizardControl :steps="steps" />
  </div>
</template>
<script>
import WizardPanel from '@/components/records/WizardPanel'
import WizardControl from '@/components/records/WizardControl'

export default {
  name: 'RecordNewForm',
  components: { WizardPanel, WizardControl },
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
        { name: 'Wizard', link: { name: 'RecordNewWizard' }}, 
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