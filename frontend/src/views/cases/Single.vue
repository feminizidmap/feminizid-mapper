<template>
<div class="codelists container-fluid">
  <div class="row">
    <nav aria-label="breadcrumb">
      <ol class="breadcrumb">
        <li class="breadcrumb-item">
          <router-link to="/cases" class="">Alle Fälle</router-link>
        </li>
        <li class="breadcrumb-item active" aria-current="page">{{ fcase.attributes.ident }}</li>
      </ol>
    </nav>
    <hr>
  </div>
  <header class="mt-3 mb-2">
    <h1 class="fs-1 fw-bold">{{ fcase.attributes.ident }}</h1>
    <CDate :item="fcase" />
  </header>
  <div class="row my-3">
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
  },
  computed: {
    deserializedSources() {
      if (this.fcase && this.fcase !== '') {
        return JSON.parse(this.fcase.attributes.sources)
      } else {
        return null
      }
    }
  }
}
</script>
