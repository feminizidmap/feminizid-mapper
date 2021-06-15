<template>
<section>
  <h2>{{ title }}</h2>

  <form @submit.prevent="sendForm">
    <slot></slot>

    <Accordion :lists="codelists"
               :accName="name"></Accordion>
  </form>
</section>
</template>
<script>
  import Accordion from '@/components/Accordion'
export default {
  name: "CaseFormWrapper",
  props: { title: String,
           name: String,
           allowedLists: Array },
  components: { Accordion },
  methods: {
    sendForm() {
      console.log(`${this.name} form was send`)
    }
  },
  computed: {
    codelists() {
      return this.$store.state.codelists.filter(x => this.allowedLists.includes(x.identifier))
    }
  }
}

</script>
