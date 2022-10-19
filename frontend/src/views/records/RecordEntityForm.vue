<template>
<div>
  <RecordFormWrapper :title="title" 
                   name="'title' + Form"
                   :allowedLists="allowedCodelists"
                   modelName="Entity">
    <div 
        v-for="a in attributes"
        :key="a.id"
        class="mb-4"
    >
        <label :for="a.name" class="form-label">{{ a.name }}</label>
        <p>{{ a.description }}</p>
        <input v-if="a.type === 'field'" type="" class="form-control" :id="a.name" placeholder="">
        <select v-if="a.type === 'category'" class="form-control" :id="a.name"></select> // TODO collection
    </div>
  </RecordFormWrapper>
</div>
</template>
<script>
import RecordFormWrapper from '@/components/records/RecordFormWrapper'

export default {
  name: 'RecordCrime',
  components: { RecordFormWrapper },
  data() {
    return {
      modelName: 'entity',
      allowedCodelists: [8, 9], // TODO ???
      title: this.$route.params.entityname,
      attributes: []
    }
  },
  created() {
    if(this.$route.query.attributes) {
        this.attributes = JSON.parse(this.$route.query.attributes)
    }
  },
  mounted() {
    console.log(this.attributes)
  }
}
</script>