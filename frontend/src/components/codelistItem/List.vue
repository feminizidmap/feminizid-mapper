<template>
  <section class="row">
    <div class="accordion accordion-flush mb-5" id="accordionCodelistItems" v-if="items.length">
      <div class="accordion-item"
           v-for="item in items"
           :key="item.id">
        <h2 class="accordion-header" :id="headerId(item)">
          <button class="accordion-button collapsed" type="button"
                  data-bs-toggle="collapse"
                  :data-bs-target="'#' + collapseId(item)" aria-expanded="false"
                  :aria-controls="collapseId(item)">
            <span class="badge bg-secondary me-2">{{ item.identifier }}</span>
            <span v-if="nameByIdentAndLang(item.identifier, $i18n.locale).length">
              {{ nameByIdentAndLang(item.identifier, $i18n.locale)[0].name }}</span>
            <span v-else>_</span>
          </button></h2>

        <div :id="collapseId(item)"
               class="accordion-collapse collapse"
               :aria-labelledby="headerId(item)"
               data-bs-parent="#accordionCodelistItems">
          <div class="accordion-body">
            <ListItem
              v-for="l in listByIdent(item.identifier)"
              :key="l.id"
              :itemId="l.id"></ListItem>

            <div class="row" v-if="listByIdent(item.identifier).length < $i18n.availableLocales.length">
              <div class="col col-1"></div>
              <div class="col">
                <p>{{ $t('layout.incomplete') }}</p>
              </div>
              <div class="col col-2">
                <Form v-if="showIfAdmin()"
                      :codelistId="codelistId"
                      :identifier="item.identifier">
                  <i class="fas fa-plus"></i> {{ $t('forms.create') }}</Form>
              </div>
            </div>
          </div>
        </div>

      </div>
    </div>
    <p v-else>{{ $t('models.codelistItem.noSuch') }}</p>
  </section>
</template>
<script>
 import { sortBy } from 'lodash'
 import Form from '@/components/codelistItem/Form'
 import ListItem from '@/components/codelistItem/ListItem'

 export default {
   name: 'CodelistItemList',
   props: ['codelistId'],
   components: {
     ListItem,
     Form
   },
   data () {
     return {
       editedItem: {}
     }
   },
   methods: {
     headerId(item) {
       return `accordeon-heading-${item.id}`
     },
     collapseId(item) {
       return `accordeon-collapse-${item.id}`
     },
     nameByIdentAndLang(ident, lang) {
       return this.items
                  .filter(x => x.identifier == ident)
                  .filter(x => x.lang == lang)
     },
     listByIdent(ident) {
       return this.items.filter(x => x.identifier == ident)
     },
     showIfAdmin() {
       return this.$store.getters.isAdmin
     }
   },
   computed: {
     items() {
       return sortBy(this.$store.getters.getCodelistItemsByListId(this.codelistId), x => x.identifier)
     }
   }
 }
</script>
