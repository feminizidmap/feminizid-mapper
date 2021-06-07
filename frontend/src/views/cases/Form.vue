<template>
<div class="codelists container-fluid">
  <div class="row">
    <router-link to="/cases">Zurück</router-link>
  </div>
  <hr>
  <div class="row my-2">
    <CaseForm />
  </div>

</div>
</template>

<script>
  import CaseForm from '@/components/cases/Form'


export default {
  name: 'CaseSingle',
  components: { CaseForm },
  data() {
    return {
      //fcase: null
    }
  },
  created() {
    //this.fcase = this.$store.getters.getCaseById(this.$route.params.caseid)
    //this.fcase = this.$route.params.caseid
  },
  computed: {

  }
}
</script>
