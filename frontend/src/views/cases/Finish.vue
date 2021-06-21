<template>
<div>
  <div v-if="hasNewCase" class="text-center border border-4  p-4">
    <p>Fall <strong>{{ $store.state.newCase.ident}}</strong></p>
    <p>@todo render summary</p>

    <button
      v-if="isLoading"
      class="btn btn-primary" type="button" disabled>
      <span class="spinner-border spinner-border-sm" role="status" aria-hidden="true"></span>
      <span class="visually-hidden">Loading...</span>
    </button>
    <button v-else class="btn btn-primary"
            @click.prevent="createNewCase">Fall speichern</button>
  </div>
</div>
</template>
<script>

export default {
  name: 'CaseFinish',
  data() {
    return {
      isLoading: false
    }
  },
  methods: {
  },
  computed: {
    hasNewCase() {
      return !this.$store.getters.isNewCaseEmpty
    }
  }
}
</script>
