<template>
<div class="codelists container-fluid">
  <div class="row">
    <nav aria-label="breadcrumb">
      <ol class="breadcrumb">
        <li class="breadcrumb-item">
          <router-link to="/records" class="">Alle Fälle</router-link>
        </li>
        <li class="breadcrumb-item active" aria-current="page">{{ record.ident }}</li>
      </ol>
    </nav>
    <hr>
  </div>
  <header class="mt-3 mb-2">
    <h1 class="fs-1 fw-bold">{{ record.ident }}</h1>
    <CDate :item="record" />
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

  <div class="row my-2" v-if="record.relationships">
    <div v-for="(r,i) in record.relationships" :key="i" class="col col-12">
      <h3 class="h2">{{r.data[0].type}}</h3>
      <div v-for="(x, j) in r.data" :key="j">
        {{x.id}}
      </div>
    </div>
  </div>
</div>
</template>

<script>
import CDate from '@/components/records/Date'

export default {
  name: 'RecordSingle',
  components: { CDate },
  data() {
    return {
      record: null
    }
  },
  created() {
    if (!this.$store.state.signedIn) {
      this.$router.replace('/')
    } else {
      this.$store.dispatch('fetchRecords')
    }
    console.log(this.$store.getters.getRecordById(this.$route.params.recordid))
    this.record = this.$store.getters.getRecordById(this.$route.params.recordid)
  },
  computed: {
    deserializedSources() {
      if (this.record && this.record.sources) {
        return JSON.parse(this.record.sources)
      } else {
        return null
      }
    }
  }
}
</script>
