<template>
<section>
  <h2>{{ title }}</h2>

  <form @submit.prevent="sendForm">
    <slot></slot>

    <Accordion :lists="codelists"
               :accName="name"
               @inputChange="handleInputChange"></Accordion>
  </form>
</section>
</template>
<script>
  import Accordion from '@/components/Accordion'
export default {
  name: "CaseFormWrapper",
  props: { title: String,
           name: String,
           allowedLists: Array,
           modelName: String },
  components: { Accordion },
  methods: {
    handleInputChange(list, item) {
      let d = new Date()
      let propValue = { prop: `${this.modelName}_${list.identifier}`,
                        value: item.id }
      this.$store.commit('setNewCaseProperty', propValue)
      this.$store.commit('pushNewCaseHistory', { message: `Changed ${item.name} as ${list.name} to ${this.modelName}`, date: d, type: 'info'})
    }
  },
  computed: {
    codelists() {
      return this.$store.state.codelists.filter(x => this.allowedLists.includes(x.identifier))
    }
  }
}

</script>
