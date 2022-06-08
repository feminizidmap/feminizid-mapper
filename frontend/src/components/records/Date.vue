<template>
<div class="text-secondary" v-if="item.attributes">
  <span>Erstellt am {{dateFormat(item.attributes.created_at)}} von {{ userName(item) }}.</span><br>
  <span>Zuletzt upgedatet am {{dateFormat(item.attributes.updated_at)}} von {{ userName(item) }}.</span>
</div>
</template>
<script>
export default {
  name: 'RecordDate',
  props: ['item'],
  methods: {
    dateFormat(date) {
      let d = new Date(date);
      let opt = { year: 'numeric', month: 'long', day: 'numeric'}
      return d.toLocaleString('de-DE', opt);
    },
    userName() {
      return 'generic';
    }
  }
}
</script>
