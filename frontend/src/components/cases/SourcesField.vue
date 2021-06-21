<template>
<form @submit.prevent="submitForm" name="">
  <div v-for="(source, i) in sources"
       :key="i">
    <label :for="source.slug" class="form-label">{{ source.name }}</label>
    <input type="url"
           class="form-control"
           :id="source.id"
           placeholder="http://yoursource.de"
           @change="updateSourceValue"
           v-model="sources[i].url ">

    <button class="btn btn-outline-danger" type="button" @click.prevent="rmSourceField(source)">Quelle entfernen</button>
  </div>

  <div><button
         class="btn btn-outline-primary"
         type="button"
         @click.prevent="addSourceField">Quelle hinzufügen</button></div>

</form>
</template>
<script>
export default {
  name: 'SourcesField',
  data() {
    return {
      sources: []
    }
  },
  created() {
    if (!this.$store.isNewCaseEmpty) {
      this.sources = JSON.parse(this.$store.state.newCase.sources)
    }
  },
  methods: {
    addSourceField() {
      let d = new Date()
      let id = this.sources.length ? this.sources.[this.sources.length -1].id + 1 : 0
      this.sources.push({ id: id,
                          slug: `source-${id}`,
                          name: `Quelle ${id}`,
                          url: ''})
      this.$store.commit('pushNewCaseHistory', { message: `Added source ${id}`, date: d, type: 'info'})
    },
    rmSourceField(id) {
      let d = new Date()
      this.sources.splice(this.sources.indexOf(id), 1)
      this.$store.commit('pushNewCaseHistory', { message: `Removed source ${id.id}`, date: d, type: 'info'})
    },
    updateSourceValue(ev) {
      let d = new Date()
      let s = JSON.stringify(this.sources
                             .map(x => { return { id: x.id, url: x.url }})
                             .filter(x => x.url !== ''))
      this.$store.commit('setNewCaseProperty', { prop: 'sources', value: s })
      this.$store.commit('pushNewCaseHistory', { message: `Changed source ${ev.target.id} to ${ev.target.value}`, date: d, type: 'info'})
    }
  }
}

</script>
