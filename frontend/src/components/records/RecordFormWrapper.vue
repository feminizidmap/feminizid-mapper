<template>
    <section>
        <h2>{{ title }}</h2>

        <form @submit.prevent="sendForm">
            <slot></slot>
            <Accordion :lists="categories"
               :accName="name"
               @inputChange="updateEntityValue">
            </Accordion>
        </form>
    </section>
</template>
<script>
 import { mapState, mapGetters, mapActions } from 'vuex'

 import Accordion from '@/components/Accordion'
 export default {
     name: "RecordFormWrapper",
     props: { title: String,
              name: String,
              modelName: String },
     components: { Accordion },
     methods: {
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
     },
     computed: {
         ...mapState(['currentRecord']),
         ...mapGetters(['getEntityValue']),
         currentEntities() {
             return this.currentRecord.entities ? this.currentRecord.entities : []
         },
         categories() {
             return this.attributes = JSON.parse(this.$route.query.attributes)
         }
     },
 }

</script>
