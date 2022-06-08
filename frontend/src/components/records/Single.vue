<template>
<div class="records-single">
  <h2 class="h1">{{ frecord.attributes.ident }}</h2>
</div>
</template>
<script>
export default {
  name: 'RecordsSingle',
  props: ['item'],
  data() {
    return {

    }
  },
  created() {
    //this.$httpSecured.get('/records/')
    //    .then(response => { this.records = response.data.data })
    //    .catch(error => this.$store.commit('addAlert', { type: 'error', message: error}))

  },
  methods: {

  }
}

</script>
