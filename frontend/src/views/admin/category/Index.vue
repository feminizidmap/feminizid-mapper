<template>
<div class="container-fluid categories">
  <header class="row">
    <h2 class="h1">{{ $t('layout.categories.title') }}</h2>
    <p class="fs-5">{{ $t('layout.categories.blurb') }}</p>
    <hr>
  </header>
  <div class="row mt-5">
    <router-view></router-view>
  </div>
</div>
</template>

<script>

export default {
  name: 'CategoryIndex',
  created() {
    this.populateCodelists()
  },
  methods: {
    populateCodelists() {
      this.$http.secured.get('/categories')
        .then(response => {
          this.$store.commit('setCategories', response.data)
        })
        .catch(error => {
          this.$store.commit('addAlert', { type: 'error', message: error })
        })
      this.$http.secured.get('/category_items')
        .then(resp => {
          this.$store.commit('setCategoryItems', resp.data)
        })
           .catch(error => { this.$store.commit('addAlert', { type: 'error', message: error}) })
     }
   },
   computed: {
     lists() {
       return this.$store.state.categories
     }
   }
 }
</script>
