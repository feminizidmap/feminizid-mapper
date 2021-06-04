<template>
<li class="list-group-item d-flex justify-content-between">
  <div class="">
    <QuickView :fcase="item" />
    <hr>
    <CDate :item="item" />
  </div>
  <div>
    <router-link  class="btn btn-outline-primary me-2"
                  :to="{name: 'CaseSingle', params: { caseid: item.id}}">
      <i class="fa fa-eye"></i>
      <span class="visually-hidden">{{ $t('forms.see') }}</span></router-link>
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
  import CDate from '@/components/cases/Date'

export default {
  name: 'CaseItemComplex',
  components: { QuickView, CDate },
  props: ['item'],
  methods: {
    showIfAdmin() {
      return this.$store.getters.isAdmin
    },
  }
}
</script>
