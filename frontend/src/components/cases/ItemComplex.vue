<template>
<li class="list-group-item d-flex justify-content-between">
  <div class="">
    <QuickView :fcase="item" />
    <hr>
    <div class="text-secondary">
      <span>Erstellt am {{dateFormat(item.attributes.created_at)}} von {{}}.</span><br>
      <span>Zuletzt upgedatet am {{dateFormat(item.attributes.updated_at)}} von {{}}.</span>
    </div>
  </div>
  <div>
    <button  class="btn btn-outline-primary me-2">
      <i class="fa fa-eye"></i>
      <span class="visually-hidden">{{ $t('forms.see') }}</span></button>
    <button  class="btn btn-outline-primary me-2">
      <i class="fa fa-edit"></i>
      <span class="visually-hidden">{{ $t('forms.edit') }}</span></button>
    <button v-if="showIfAdmin()"  class="btn btn-outline-danger">
      <i class="fa fa-trash-alt"></i>
      <span class="visually-hidden">{{ $t('forms.delete') }}</span></button>
  </div>
</li>
</template>
<script>
  import QuickView from '@/components/cases/QuickView'

export default {
  name: 'CaseItemComplex',
  components: { QuickView },
  props: ['item'],
  methods: {
    dateFormat(date) {
      let d = new Date(date);
      let opt = { weekday: 'long', year: 'numeric', month: 'long', day: 'numeric',
                  hour: '2-digit', minute: '2-digit', timeZoneName: 'short' }
      return d.toLocaleString('de-DE', opt);
    },
    showIfAdmin() {
      return this.$store.getters.isAdmin
    },
  }
}
</script>
