<template>
<form @submit.prevent="submitForm" name="">
  <div v-for="(source, i) in sources"
       :key="i">
    <label :for="source.slug" class="form-label">{{ source.name }}</label>
    <input type="url" class="form-control" :id="source.slug" placeholder="http://yoursource.de" v-model="sources[i].url ">

    <button class="btn btn-outline-danger" type="button" @click.prevent="rmSourceField(source)">Quelle entfernen</button>
  </div>

  <div><button
         class="btn btn-outline-primary"
         type="button"
         @click.prevent="addSourceField">Quelle hinzufügen</button></div>

  <button v-if="saving" class="btn btn-primary" type="button" disabled>
    <span class="spinner-grow spinner-grow-sm" role="status" aria-hidden="true"></span>
    Speichern...
  </button>
  <button v-else type="submit" class="btn btn-primary">Speichern</button>
</form>
</template>
<script>
export default {
  name: 'SourcesField',
  props: ['ident', 'existingSources'],
  data() {
    return {
      sources: [],
      saving: false
    }
  },
  created() {
    if (this.existingSources) {
      this.sources = this.existingSources
    }
  },
  methods: {
    addSourceField() {
      let id = this.sources.length ? this.sources.[this.sources.length -1].id + 1 : 0
      this.sources.push({ id: id,
                          slug: `source-${id}`,
                          name: `Quelle ${id}`,
                          url: ''})
    },
    rmSourceField(id) {
      this.sources.splice(this.sources.indexOf(id), 1)
    },
    submitForm(ev) {
      this.saving = true
      let s = JSON.stringify(this.sources
                             .map(x => { return { id: x.id, url: x.url }})
                             .filter(x => x.url !== ''))

      if (this.$route.name === 'CaseNew') {
        if (s.length) {
          this.newCase(s)
        } else {
          console.log(ev, s, "EMPTY")
          this.saving = false
        }
      } else {
        this.updateCase(s)
      }
    },
    newCase(s) {
      this.$http.secured.post('/case', {
        fcase: {
          ident: this.ident,
          sources: s
        }
      }).then(response => {
        this.$store.commit('addToCases', response.data.data)
        this.saving = false
      }).catch(error => { this.$store.commit('addAlert', { message: `ERoor bill robinson ${error}`, type: 'error'})})
    },
    updateCase(s) {
      this.$http.secured.patch(`/case/${this.$route.params.caseid}`, {
        fcase: {
          ident: this.ident,
          sources: s
        }
      }).then(response => {
        this.$store.commit('updateSingleCase', response.data)
        this.saving = false
      }).catch(error => { this.$store.commit('addAlert', { message: `ERoor bill robinson ${error}`, type: 'error'})})
    }
  }
}

</script>
