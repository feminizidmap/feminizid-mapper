<template>
<div>
  <RecordFormWrapper :title="title" 
                   name="'title' + Form"
                   :allowedLists="allowedCodelists"
                   modelName="Entity">
    <div 
        v-for="a in attributes"
        :key="a.id"
        class="mb-4"
    >
        <label :for="a.name" class="form-label">{{ a.name }}</label>
        <p>{{ a.description }}</p>
        <input v-if="a.type === 'field'" type="" class="form-control" :id="a.name" :value="entityValue(a.name, a.type)" @change="updateEntityValue(a.name, $event.target.value, a.type)" placeholder="">
        <select v-if="a.type === 'category'" class="form-control" :id="a.name" :value="entityValue(a.name, a.type)" @change="updateEntityValue(a.name, $event.target.value, a.type)"></select> // TODO collection
    </div>
  </RecordFormWrapper>
</div>
</template>

<script>
import RecordFormWrapper from '@/components/records/RecordFormWrapper'
import { mapState, mapGetters, mapActions } from 'vuex'

export default {
  name: 'RecordEntity',
  components: { RecordFormWrapper },
  data() {
    return {
      modelName: 'entity',
      allowedCodelists: [8, 9], // TODO ???
      title: this.$route.params.entityname,
      attributes: []
    }
  },
  created() {
    if(this.$route.query.attributes) {
        this.attributes = JSON.parse(this.$route.query.attributes)
    }
  },
  mounted() {
    // console.log(this.attributes)
  },
  computed: {
    ...mapState(['currentRecord']),
    ...mapGetters(['getEntityValue']),
    currentEntities() {
      return this.currentRecord.entities ? this.currentRecord.entities : []
    }
  },
  methods: {
    ...mapActions(['updateCurrentRecordProperty']),
    entityValue(name, type) {
      return this.getEntityValue(this.title, name, type)
    },
    updateEntityValue(name, value, type) {
      const entityIndex = this.currentEntities?.findIndex(entity => entity.name === this.title)

      console.log(this.currentRecord)

      if (entityIndex === -1 || entityIndex === undefined) {
        // Entity does not exist, create a new one
        console.log("Creating a new entity entry for this record")
        const newEntity = {
          name: this.title,
          slug: this.title, // TODO do we need this?
          fields: [],
          properties: []
        }

        if (type === 'field') {
          newEntity.fields = [{ name: name, value: value }]
        } else if (type === 'category') {
          newEntity.properties = [{ name: name, value: value }]
        }

        this.currentEntities.push(newEntity)
      } else {
        // Entity already exists, update the property value
        if (type === 'field') {
          const fieldIndex = this.currentEntities[entityIndex].fields.findIndex(field => field.name === name)

          if (fieldIndex === -1) {
            // Field does not exist, create a new one
            this.currentEntities[entityIndex].fields.push({ name: name, value: value })
          } else {
            // Field exists, update its value
            this.currentEntities[entityIndex].fields[fieldIndex].value = value
          }
        } else if (type === 'category') {
          const propIndex = this.currentEntities[entityIndex].properties.findIndex(prop => prop.name === name)

          if (propIndex === -1) {
            // Property does not exist, create a new one
            this.currentEntities[entityIndex].properties.push({ name: name, value: value })
          } else {
            // Property exists, update its value
            this.currentEntities[entityIndex].properties[propIndex].value = value
          }
        }
      }

      let d = new Date()
      this.$store.commit('pushCurrentRecordHistory', { message: `Changed ${name} to ${value}`, date: d, type: 'info'})
      this.$store.commit('setCurrentRecordProperty', { prop: 'entities', value: this.currentEntities })
    }
  }
}
</script>

