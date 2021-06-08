<template>
<li class="list-group-item d-flex justify-content-between">
  <div class="">
    <QuickView :fcase="item" />
    <hr>
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
                  :to="{name: 'CaseSingle', params: { caseid: item.id}}">
      <i class="fa fa-eye"></i>
      <span class="visually-hidden">{{ $t('forms.see') }}</span></router-link>
    <router-link :to="{name: 'CaseEditMeta', params: {caseid: item.id}}"  class="btn btn-outline-primary me-2">
      <i class="fa fa-edit"></i>
      <span class="visually-hidden">{{ $t('forms.edit') }}</span></router-link>
    <button v-if="showIfAdmin()"
            class="btn btn-outline-danger"
            @click.prevent="rmCase">
      <i class="fa fa-trash-alt"></i>
      <span class="visually-hidden">{{ $t('forms.delete') }}</span></button>
    </template>
  </div>
</li>
</template>
<script>
  import QuickView from '@/components/cases/QuickView'
  import CDate from '@/components/cases/Date'

export default {
  name: 'CaseItemComplex',
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
    reallyRmCase() {
      this.$http.secured.delete(`/case/${this.item.id}`).then(() => {
        this.$store.commit('removeSingleCase', this.item)
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
        this.reallyRmCase()
        clearInterval(this.rmIntervalId)
      }
    },
    rmCase() {
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
