<template>
<div class="case-quickview">
  <h3 class="h4" @click.prevent="toggleOpen">
    <i class="fa fa-caret-down" v-if="isOpen"></i>
    <i class="fa fa-caret-right" v-else></i>
    {{ fcase.attributes.ident }}</h3>
  <div v-if="isOpen"
       class="d-flex">
    <div v-for="(r,i) in fcase.relationships" :key="i">
      <h4 class="h5">{{r.data[0].type}}</h4>
      <div v-for="(x, j) in r.data" :key="j">
        {{x.id}}
      </div>
    </div>
  </div>
</div>
</template>
<script>
export default {
  name: 'CaseQuickView',
  props: ['fcase'],
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
