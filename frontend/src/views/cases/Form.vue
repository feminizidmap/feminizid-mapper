<template>
<div class="codelists container-fluid">
  <div class="row">
    <router-link to="/cases">Zurück</router-link>
  </div>
  <hr>
  <div class="row my-2">
    <EditForm v-if="fcase" :fcase="fcase" />
    <NewForm v-else />
  </div>
</div>
</template>
<script>
import NewForm from '@/components/cases/NewForm'
import EditForm from '@/components/cases/EditForm'

export default {
  name: 'CaseSingle',
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
      if (this.$route.name === 'CaseEdit') {
        this.fcase = this.$store.getters.getCaseById(this.$route.params.caseid)
      } else {
        this.fcase = null
      }
    }
  },
  watch: {
    '$route.path'() {
      this.setFcase()
    }
  }
}
</script>
