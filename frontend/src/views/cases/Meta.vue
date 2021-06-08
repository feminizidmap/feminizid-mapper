<template>
<div>
  <EditForm v-if="fcase" :fcase="fcase" />
  <NewForm v-else />
</div>
</template>
<script>
import NewForm from '@/components/cases/NewForm'
import EditForm from '@/components/cases/EditForm'

export default {
  name: 'CaseForm',
  components: { NewForm, EditForm },
  data() {
    return {
      fcase: null
    }
  },
  created() {
    this.setFcase()
  },
  methods: {
    setFcase() {
      if (this.$route.name.match(/CaseNew/)) {
        this.fcase = null
      } else {
        this.fcase = this.$store.getters.getCaseById(this.$route.params.caseid)
      }
    }
  },
  watch: {
    '$route'() {
      this.setFcase()
    }
  }
}
</script>
