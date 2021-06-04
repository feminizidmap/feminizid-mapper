<template>
<div class="codelists container-fluid">
  <div class="row">
    <router-link to="/cases">Zurück</router-link>
  </div>
  <hr>
  <div class="row my-2">
    <h2 class="h1">{{ fcase.attributes.ident }}</h2>
    <CDate :item="fcase" />
  </div>
  <div class="row my-2">
    <div v-for="(r,i) in fcase.relationships" :key="i">
      <h3 class="h2">{{r.data[0].type}}</h3>
      <div v-for="(x, j) in r.data" :key="j">
        {{x.id}}
      </div>
    </div>
  </div>
</div>
</template>

<script>
  //import Single from '@/components/cases/Single'
  import CDate from '@/components/cases/Date'

export default {
  name: 'CaseSingle',
  components: { CDate },
  data() {
    return {
      fcase: null
    }
  },
  created() {
    this.fcase = this.$store.getters.getCaseById(this.$route.params.caseid)
    //this.fcase = this.$route.params.caseid
  },
  computed: {

  }
}
</script>
