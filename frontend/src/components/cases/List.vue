<template>
<div class="cases-single">
  <template v-if="fcase">
    <h1>{{ fcase.ident }}</h1>
  </template>
</div>
</template>
<script>
export default {
    name: 'CasesSingle',
    data() {
        return {
            fcase: null,
        }
    },
    created() {
        //this.$http.secured.get('/case/')
        //    .then(response => { this.cases = response.data.data })
        //    .catch(error => this.$store.commit('addAlert', { type: 'error', message: error}))

    },
    methods: {

    }
}

</script>
