<template>
  <div class="codelists container-fluid">
    <div class="row my-2">
      <h2 class="display-6">{{ $t('layout.codelist') }}</h2>
    </div>
    <div class="row">
      <div class="col-3">
        <nav class="list-group mb-4">
          <router-link class="list-group-item"
                       :to="{name: 'AdminCodelistList'}"
                       :class="{'active': !$route.params.codelistkey}"
                       :aria-current="$route.params.codelistkey">
            {{ $t('layout.overview') }}</router-link>

          <router-link :to="{ name: 'CodelistSingle', params: { codelistkey: list.id}}"
            v-for="list in lists"
            :key="list.id"
            :list="list"
            class="list-group-item"
            :class="{'active': ($route.params.codelistkey == list.id)}"
            :aria-current="$route.params.codelistkey == list.id">
            {{ list.name }}</router-link>
        </nav>
      </div>

      <div class="col">
        <router-view></router-view>
      </div>
    </div>
  </div>
</template>

<script>
 import { sortBy } from 'lodash'

 export default {
   name: 'UsersList',
   created () {
     if (this.$store.state.signedIn) {
       this.populateCodelists()
     } else {
       this.$router.replace('/')
     }
   },
   methods: {
     populateCodelists() {
       this.$http.secured.get('/codelist')
           .then(response => {
             this.$store.commit('setCodelists', response.data)
           })
           .catch(error => { this.setError(error, 'Something went wrong') })
       this.$http.secured.get('/codelist_items')
           .then(resp => {
             this.$store.commit('setCodelistItems', resp.data)
           })
           .catch(error => { this.setError(error, 'Something went wrong') })
     },
     setError (error, text) {
       const e = (error.response && error.response.data && error.response.data.error) || text
       this.$store.commit('addAlert', { type: 'error', message: e})
     }
   },
   computed: {
     lists() {
       let filtered = this.$store.state.codelists.filter(x => x.lang == this.$i18n.locale)
       return sortBy(filtered, (o) => o.identifier)
     }
   }
 }
</script>
