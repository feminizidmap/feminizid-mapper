<template>
  <div class="changes">
    <h3>{{ $t('changes.title.recent') }}</h3>
    <ul class="list-group">
      <li class="list-group-item"
          v-for="change in changes"
          :key="change.id"
          :change="change">
      </li>
    </ul>
  </div>
</template>

<script>
 export default {
   name: 'ChangesList',
   data () {
     return {
       changes: [],
     }
   },
   created () {
     // if (!this.$store.state.signedIn) {
     //   this.$router.replace('/')
     // } else {
     //   this.$http.secured.get('/changes')
     //       .then(response => { this.changes = response.data })
     //       .catch(error => this.setError(error, 'Something went wrong'))
     // }
   },
   methods: {}
 }
</script>

<style lang="css">
</style>
