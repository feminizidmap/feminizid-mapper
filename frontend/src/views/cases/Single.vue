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
    <h3>Quellen</h3>
    <ul class="col col-12" v-if="deserializedSources">
      <li v-for="source in deserializedSources" :key="source.id" class="list-group-item">
        <a :href="source.url" target="_blank">
        <i class="fas fa-external-link-square-alt"></i>
          {{source.url}}
        </a>

        @todo link pdf
      </li>
    </ul>
    <p v-else>No sources</p>
  </div>

  <div class="row my-2" v-if="fcase.relationships.length">
    <div v-for="(r,i) in fcase.relationships" :key="i" class="col col-12">
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
    deserializedSources() {
      //debugger // eslint-disable-line no-debugger
      if (this.fcase && this.fcase !== '') {
        return JSON.parse(this.fcase.attributes.sources)
      } else {
        return null
      }
    }
  }
}
</script>
