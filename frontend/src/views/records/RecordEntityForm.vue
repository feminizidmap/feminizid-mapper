<template>
    <div>
        <RecordFormWrapper :title="title"
                   :name="`${title}-${modelName}-acc`"
                   modelName="Entity">
        </RecordFormWrapper>
    </div>
</template>

<script>
 import RecordFormWrapper from '@/components/records/RecordFormWrapper'
 import { mapState, mapGetters, mapActions } from 'vuex'

 export default {
     name: 'RecordEntity',
     components: { RecordFormWrapper },
     data() {
         return {
             modelName: 'entity',
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
         // console.log(this.attributes)
     },

     methods: {

     }
 }
</script>
