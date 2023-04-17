<template>
<li class="list-group-item d-flex justify-content-between border-3 mb-2 record-item-complex">
  <h3 class="fw-bold h4 mt-2">{{ item.identifier }}</h3>
  <div class="">
    <QuickView :record="item" />
    <CDate :item="item" />
  </div>
  <div>
    <template v-if="rmIntervalId">
      <div class="progress">
        <div class="progress-bar progress-bar-striped bg-warning progress-bar-animated" role="progressbar" :style="rmTimerLeftWidth" :aria-valuenow="rmTimerLeft" aria-valuemin="0" aria-valuemax="100"></div>
      </div>
      <p>Permanently deleting</p>
      <button @click.prevent="stopRm" class="btn btn-outline-primary mt-3">Cancel delete</button>
    </template>
    <template v-else>
    <router-link  class="btn btn-outline-primary me-2"
                  :to="{name: 'RecordSingle', params: { recordid: item.id } }">
      <i class="fa fa-eye"></i>
      <span class="visually-hidden">{{ $t('forms.see') }}</span></router-link>
    <router-link  class="btn btn-outline-primary me-2"
                  :to="{name: 'RecordEdit', params: { recordid: item.id } }">
      <i class="fa fa-edit"></i>
      <span class="visually-hidden">{{ $t('forms.edit') }}</span></router-link>
    <button v-if="showIfAdmin()"
            class="btn btn-outline-danger"
            @click.prevent="rmRecord">
      <i class="fa fa-trash-alt"></i>
      <span class="visually-hidden">{{ $t('forms.delete') }}</span></button>
    </template>
  </div>
</li>
</template>
<script>
  import QuickView from '@/components/records/QuickView'
  import CDate from '@/components/records/Date'

export default {
  name: 'RecordItemComplex',
  components: { QuickView, CDate },
  props: ['item'],
  data() {
    return {
      rmIntervalId: null,
      rmTimer: null,
      rmTimerLeft: null,
      rmTimerLeftWidth: null,
      rmMaxTime: 6000
    }
  },
  methods: {
    showIfAdmin() {
      return this.$store.getters.isAdmin
    },
    reallyRmRecord() {
      this.$httpSecured.delete(`/records/${this.item.id}`).then(() => {
        this.$store.commit('removeSingleRecord', this.item)
        this.$store.commit('addAlert', { message: `Deleted item`, type: 'info'})
      }).catch(function (error) {
        this.$store.commit('addAlert', { message: `Error bill robinson ${error}`, type: 'error'})
      })
    },
    rmCountdown() {
      let d = new Date()
      let diff = d.getTime() -this.rmTimer.getTime()

      this.rmTimerLeft = Math.floor(diff / this.rmMaxTime * 100)
      this.rmTimerLeftWidth = `width: ${this.rmTimerLeft}%;`

      if (diff > this.rmMaxTime + 1000) {
        this.reallyRmRecord()
        clearInterval(this.rmIntervalId)
      }
    },
    rmRecord() {
      this.rmTimer = new Date()
      this.rmTimerLeft = 0
      this.rmTimerLeftWidth = 'width: 0%;'
      this.rmIntervalId = setInterval(() => {
        this.rmCountdown()
      }, 500)
    },
    stopRm() {
      clearInterval(this.rmIntervalId)
      this.rmIntervalId = null
    }
  }
}
</script>
<style>
  .record-item-complex:hover {
  background-color: lightgrey;
  }
</style>
