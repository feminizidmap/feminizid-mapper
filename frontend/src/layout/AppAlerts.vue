<template>
  <div v-if="alerts.length" class="container-fluid">
    <div class="alert my-2"
         :class="[
           {'alert-danger': alert.type === 'error'},
           {'alert-info': alert.type === 'notice'}] "
         v-for="alert in alerts"
         :key="alert.message"
         :alert="alert">
      <span class="ml-5">{{ alert.message }}</span>
      <button type="button" @click.prevent="rmAlert(alert)"
              class="btn-close align-middle float-end" aria-label="Close"></button>
    </div>
  </div>
</template>

<script>
 export default {
   name: 'AppAlerts',
   watch: {
     alerts(n, a) {
       //console.log(n, a, 'hullo')
       if (n.length > a.length) {
         setTimeout(() => {
           this.$store.commit('removeAlert', n[n.length -1])
         }, 5000)
       }
     }
   },
   methods: {
     rmAlert(alert) {
       this.$store.commit('removeAlert', alert)
     }
   },
   computed: {
     alerts() {
       return this.$store.getters.allAlerts
     }
   }
 }
</script>
