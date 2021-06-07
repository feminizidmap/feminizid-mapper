<template>
<form @submit.prevent="submitForm" name="">
  <div v-for="(source, i) in sources"
       :key="i">
    <label :for="source.slug" class="form-label">{{ source.name }}</label>
    <input type="url" class="form-control" :id="source.slug" placeholder="http://yoursource.de" v-model="sources[i].val ">

    <button class="btn btn-outline-danger" type="button" @click.prevent="rmSourceField(source)">Quelle entfernen</button>
  </div>

  <div><button
         class="btn btn-outline-primary"
         type="button"
         @click.prevent="addSourceField">Quelle hinzufügen</button></div>
  <button type="submit" class="btn btn-primary">Speichern</button>
</form>
</template>
<script>
export default {
  name: 'SourcesField',
  props: ['ident'],
  data() {
    return {
      sources: []
    }
  },
  methods: {
    addSourceField() {
      let id = this.sources.length ? this.sources.[this.sources.length -1].id + 1 : 0
      this.sources.push({ id: id,
                          slug: `source-${id}`,
                          name: `Quelle ${id}`,
                          val: ''})
    },
    rmSourceField(id) {
      this.sources.splice(this.sources.indexOf(id), 1)
    },
    submitForm(ev) {
      let s = JSON.stringify(this.sources
                             .map(x => { return { id: x.id, url: x.val }})
                             .filter(x => x.url !== ''))
      //debugger // eslint-disable-line no-debugger

      if (s.length) {
        console.log(ev, s, "SEND")

        this.$http.secured.post('/case', {
          fcase: {
            ident: this.ident,
            sources: s
          }
        }).then(response => {
          this.$store.commit('addToCases', response.data.data)
        }).catch(error => { this.$store.commit('addAlert', { message: `ERoor bill robinson ${error}`})})

      } else {
        console.log(ev, s, "EMPTY")
      }
    }
  }
}

</script>
