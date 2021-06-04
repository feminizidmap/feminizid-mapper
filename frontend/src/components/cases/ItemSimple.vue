<template>
<li class="list-group-item">
  <span class=""><strong>{{ item.attributes.ident }}</strong></span><br>
  <span class="text-secondary">Erstellt am {{dateFormat(item.attributes.created_at)}}</span><br>
  <span class="text-secondary">von </span>
</li>
</template>
<script>
export default {
  name: 'CaseItemSimple',
  props: ['item'],
  methods: {
    dateFormat(date) {
      let d = new Date(date);
      let opt = { weekday: 'long', year: 'numeric', month: 'long', day: 'numeric',
                  hour: '2-digit', minute: '2-digit', timeZoneName: 'short' }
      return d.toLocaleString('de-DE', opt);
    }
  }
}
</script>
