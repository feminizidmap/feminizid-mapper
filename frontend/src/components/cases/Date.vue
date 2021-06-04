<template>
<div class="text-secondary">
  <span>Erstellt am {{dateFormat(item.attributes.created_at)}} von {{}}.</span><br>
  <span>Zuletzt upgedatet am {{dateFormat(item.attributes.updated_at)}} von {{}}.</span>
</div>
</template>
<script>
export default {
  name: 'CaseDate',
  props: ['item'],
  methods: {
    dateFormat(date) {
      let d = new Date(date);
      let opt = { year: 'numeric', month: 'long', day: 'numeric',
                  hour: '2-digit', minute: '2-digit', timeZoneName: 'short' }
      return d.toLocaleString('de-DE', opt);
    }
  }
}
</script>
