<template>
  <div class="codelists container-fluid">
    <header>
      <p class="lead">Hello what is this</p>
    </header>
    <div class="row">
      <div class="accordion accordion-flush" id="accordionCodelist">
        <div class="accordion-item"
             v-for="i in identList"
             :key="i.identifier">

          <h2 class="accordion-header" :id="headerId(i)">
            <button class="accordion-button collapsed" type="button"
                    data-bs-toggle="collapse"
                    :data-bs-target="'#' + collapseId(i)" aria-expanded="false"
                    :aria-controls="collapseId(i)">
              <span class="badge bg-secondary me-2">{{ i.identifier }}</span>
              <span v-if="nameByIdentAndLang(i.identifier, $i18n.locale).length">
                {{ nameByIdentAndLang(i.identifier, $i18n.locale)[0].name }}</span>
              <span v-else>_</span>
            </button>
          </h2>

          <div :id="collapseId(i)"
               class="accordion-collapse collapse"
               :aria-labelledby="headerId(i)"
               data-bs-parent="#accordionCodelist">
            <div class="accordion-body">
              <Single
                v-for="l in listByIdent(i.identifier)"
                :key="l.id"
                :codelistId="l.id"></Single>

              <div class="row" v-if="listByIdent(i.identifier).length < $i18n.availableLocales.length">
                <div class="col col-1"></div>
                <div class="col">
                  <p>{{ $t('layout.incomplete') }}</p>
                </div>
                <div class="col col-2">
                  <Form v-if="showIfAdmin()" :identifier="i.identifier">
                    <i class="fas fa-plus"></i>
                    {{ $t('forms.create') }}</Form>
                </div>
              </div>
            </div>
          </div>

        </div>
      </div>
    </div>
    <div class="row mt-5">
      <Form v-if="showIfAdmin()" :identifier="identList.length + 1">
        <i class="fas fa-plus"></i>
        {{ $t('forms.create') }}
      </Form>
    </div>
  </div>
</template>

<script>
 import { sortBy, uniqBy } from 'lodash'
 import Single from '@/components/codelist/Single'
 import Form from '@/components/codelist/Form'

 export default {
   name: 'UsersList',
   components: { Form, Single },
   watch: {
     '$store.state.codelists': {
       handler(newish, old) {
         console.log(newish, old)
       }
     }
   },
   methods: {
     setError (error, text) {
       const e = (error.response && error.response.data && error.response.data.error) || text
       this.$store.commit('addAlert', { type: 'error', message: e})
     },
     showIfAdmin() {
       return this.$store.getters.isAdmin
     },
     headerId(list) {
       return `flush-heading-${list.id}`
     },
     collapseId(list) {
       return `flush-collapse-${list.id}`
     },
     nameByIdentAndLang(ident, lang) {
       return sortBy(this.$store.getters.getCodelistsByIdentAndLang(ident, lang),
                     x => x.identifier)
     },
     listByIdent(ident) {
       return sortBy(this.$store.getters.getCodelistsByIdent(ident), 'identifier')
     }
   },
   computed: {
     identList() {
       return sortBy(uniqBy(this.$store.state.codelists, 'identifier'), 'identifier')
     }
   }
 }
</script>
