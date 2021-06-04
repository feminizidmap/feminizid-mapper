<template>
<div class="cases-list">
  <ul v-if="filteredCases && filteredCases.length"
      class="list-group">
    <li v-for="fcase in filteredCases"
        :key="fcase.id"
        class="list-group-item">
      <span class=""><strong>{{ fcase.attributes.ident }}</strong></span><br>
      <span class="text-secondary">Erstellt am {{dateFormat(fcase.attributes.created_at)}}</span><br>
      <span class="text-secondary">von </span>
    </li>
  </ul>
  <div v-else class="alert alert-info" role="alert">
    Nothing here yet
  </div>
</div>
</template>
<script>
export default {
  name: 'CasesList',
  props: ['cases'],
  methods: {
    dateFormat(date) {
      let d = new Date(date);
      let opt = { weekday: 'long', year: 'numeric', month: 'long', day: 'numeric',
                  hour: '2-digit', minute: '2-digit', timeZoneName: 'short' }
      return d.toLocaleString('de-DE', opt);
    }
  },
  computed: {
    filteredCases() {
      return this.cases;
    }
  }
}

</script>
