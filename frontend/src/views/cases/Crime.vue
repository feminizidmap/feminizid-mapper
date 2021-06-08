<template>
<div>
  <h2>Infos zur Tat</h2>

  <form @submit.prevent="sendForm">
    <label for="address" class="form-label">Adresse</label>
    <input type="url" class="form-control" id="address" placeholder="Str Hausnummer">

    <div class="accordion" id="">
      <div v-for="codelist in codelists" :key="codelist.id" class="accordion-item">
        <h3 class="accordion-header" :id="headingId(codelist.id)">
          <button class="accordion-button" type="button" data-bs-toggle="collapse" data-bs-target="#collapseOne" aria-expanded="true" :aria-controls="collapseId(codelist.id)">
            {{ codelist.name }}
          </button>
        </h3>

        <div id="collapseOne" class="accordion-collapse collapse show" aria-labelledby="headingOne" data-bs-parent="#accordionExample">
          <div class="accordion-body">
            <p>{{ codelist.description}}</p>

            <div class="form-check" v-for="item in codelistItems(codelist.id)"
                 :key="item.id">
              <input class="form-check-input" type="radio" value="" :name="codelist.id" :id="item.id">
              <label class="form-check-label" :for="item.id">
                {{item.name}}
              </label>
            </div>
          </div>
        </div>
      </div>
    </div>

    <button type="submit" class="btn btn-primary mt-5">Speichern</button>
  </form>

</div>
</template>
<script>

export default {
  name: 'CaseCrime',
  data() {
    return {
      allowedCodelists: [8, 9]
    }
  },
  created() {
    //this.setFcase()

    //debugger // eslint-disable-line no-debugger
  },
  methods: {
    codelistItems(listId) {
      return this.$store.getters.getCodelistItemsByListId(listId)
    }
  },
  computed: {
    codelists() {
      return this.$store.state.codelists.filter(x => this.allowedCodelists.includes(x.identifier))
    }
  }
}
</script>
