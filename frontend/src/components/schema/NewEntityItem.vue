<template>
  <div class="entity-form">
    <button type="button"
            class="btn btn-primary"
            data-bs-toggle="modal" :data-bs-target="'#' + modalId">
      <slot></slot></button>

    <div class="modal fade"
         :id="modalId" tabindex="-1"
         :aria-labelledby="modalLabel" aria-hidden="true">
      <div class="modal-dialog">
        <form @submit.prevent="sendCategory" class="modal-content">
          <div class="modal-header">
            <h4 :id="modalLabel" class="modal-title">
              {{ $t('prompts.newEntity') }}</h4>
            <button type="button" class="btn-close" data-bs-dismiss="modal"
                    :aria-label="$t('forms.close')"></button></div>

          <div class="modal-body">
            <div class="form-group mb-4">
              <label>{{ $t('models.entity.name')}}
                <input class="form-control" required autocomplete="off"
                       v-model="newEntity.name" /></label></div>
            <div class="form-group mb-4">
              <label>{{ $t('models.entity.slug')}}
                <input class="form-control" required autocomplete="off"
                       v-model="newEntity.slug" readonly /></label></div>
          </div>

          <div class="modal-footer">
            <button class="btn btn-primary" type="submit" @click.prevent="emitNewEntity">
              <i class="fa fa-save me-2"></i><span>{{ $t('forms.save') }}</span></button>
            <button class="btn btn-outline-secondary" data-bs-dismiss="modal"
                    :aria-label="$t('forms.cancel')" type="button">
              <i class="fa fa-ban me-2"></i><span>{{ $t('forms.cancel') }}</span></button>
          </div>
        </form>
      </div>
    </div>
  </div>
</template>
<script>
export default {
  name: 'NewEntityItem',
  data() {
    return {
      newEntity: {}
    }
  },
  methods: {
    updateEntityName(ev) {
      this.newEntity.name = ev.target.value
      this.newEntity.slug = this.newEntity.name.toLowerCase().replaceAll(" ", "-")
    },
    emitNewEntity() {
      this.$emit('newEntity', this.newEntity)
      window.bootstrap.Modal.getInstance(document.querySelector(`#${this.modalId}`)).hide()
      this.newEntity = {}
    }
  },
  watch: {
    'newEntity.name': {
      handler(ev) {
        this.newEntity.slug = ev.toLowerCase()
          .replaceAll(" ", "-")
          .replaceAll("ä", "ae")
          .replaceAll("ö", "oe")
          .replaceAll("ü", "ue")
          .replaceAll("ß", "ss")
      }
    }
  },
  computed: {
    modalId() {
      return 'newEntityFormId'
    },
    modalLabel() {
      return 'newEntityForm'
    }
  }
}
</script>
