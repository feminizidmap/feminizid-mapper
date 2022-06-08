<template>
<div class="record-quickview">
  <h3 class="h4 fw-bold" @click.prevent="toggleOpen" v-if="frecord.attributes">
    <i class="fa fa-caret-down" v-if="isOpen"></i>
    <i class="fa fa-caret-right" v-else></i>
    {{ frecord.attributes.ident }}</h3>
  <div v-if="isOpen && frecord.relationships"
       class="d-flex">
    <div v-for="(r,i) in frecord.relationships" :key="i">
      <div v-if="r.data && r.data.length">
        <h4 class="h5">{{r.data[0].type}}</h4>
        <div v-for="(x, j) in r.data" :key="j">
          {{x.id}}
        </div>
      </div>
    </div>
  </div>
</div>
</template>
<script>
export default {
  name: 'RecordQuickView',
  props: ['frecord'],
  data() {
    return {
      isOpen: false
    }
  },
  methods: {
    toggleOpen() {
      this.isOpen = !this.isOpen
    }
  }
}
</script>
