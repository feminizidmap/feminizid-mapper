<template>
<div class="entity-item">
  <div v-if="isEditing" >
    <form class="border border-2 p-3 mb-5 rounded" @submit.prevent="updateEntity">
        <input class="form-control"
               v-model="chEntity.name" />
        <input class="form-control mt-3"
               v-model="chEntity.slug"
               readonly />
        <div class="mt-3">
        <button type="submit" class="btn btn-outline-primary">
          <i class="fas fa-save"></i>
          <span class="visually-hidden">{{ $t('actions.save') }}</span>
        </button>
        <button type="button" class="btn btn-outline-secondary ms-2" @click.prevent="unEdit">
            <i class="fa fa-ban"></i>
            <span class="visually-hidden">{{ $t('forms.cancel') }}</span></button>
        </div>
      </form>
  </div>
  <div v-else class="d-flex p-2 justify-content-between">
    <h5 class="fs-4 fw-bold">{{ entity.name }}</h5>
    <div class="me-lg-3">
      <button v-if="showIfAdmin()"
              @click.prevent="edit"
              class="btn btn-outline-primary me-2">
        <i class="fa fa-edit"></i>
        <span class="visually-hidden">{{ $t('forms.edit') }}</span></button>
      <button v-if="showIfAdmin()"
              @click.prevent="emitRmEntity"
              class="btn btn-outline-danger">
        <i class="fa fa-trash-alt"></i>
        <span class="visually-hidden">{{ $t('forms.delete') }}</span>
    </button>
    </div>
  </div>

  <div>
    <ul v-if="entity.attributes.length"
        class="list-unstyled">
      <li class="ms-3 mb-3 ps-3"
        v-for="(attr, i) in entity.attributes"
        :key="i">
        <FieldItem :field="attr"
                   @rmField="emitRmField"></FieldItem>
      </li>
    </ul>
    <div v-else class="alert alert-info ms-2 me-4 mt-3">
      {{ $t('models.field.noSuch')}}
    </div>

    <div class="mt-3">
      <NewAttributeForm @addedNewAttribute="emitNewAttribute" :ident="ident">
        <i class="far fa-plus-square"></i>
        Attribute hinzufügen
      </NewAttributeForm>

      <NewFieldForm @addedNewField="emitNewField" :ident="ident">
        <i class="far fa-plus-square"></i>
        Feld hinzufügen
      </NewFieldForm>
    </div>
  </div>
</div>
</template>
<script>
  import { slugify } from '@/util'
import FieldItem from '@/components/schema/FieldItem'
import NewFieldForm from '@/components/schema/NewFieldForm'
import NewAttributeForm from '@/components/schema/NewAttributeForm'

export default {
  name: 'EntityItem',
  components: { NewFieldForm,
                NewAttributeForm,
                FieldItem },
  props: { entity: Object, ident: Number },
  data() {
    return {
      isEditing: false,
      chEntity: {}
    }
  },
  watch: {
    'chEntity.name': {
      handler(ev) {
        this.chEntity.slug = slugify(ev)
      }
    }
  },
  methods: {
    edit() {
      this.isEditing = true
      this.chEntity = Object.assign({}, this.entity)
    },
    unEdit() {
      this.isEditing = false
    },
    updateEntity() {
      this.$emit('updateEntity', { old: this.entity, mew: this.chEntity }) // yes this a pokemon joke
      this.unEdit()
    },
    emitNewField(field) {
      let obj = { e: this.entity,
                  field }
      obj.field.type = 'field'
      this.$emit('newField', obj)
    },
    emitNewAttribute(attribute) {
      let obj = { e: this.entity,
                  field: this.$store.getters.getCategoryById(attribute) }
      obj.field.type = 'category'

      this.$emit('newField', obj)
    },
    emitRmField(attr) {
      this.$emit('rmField', {e: this.entity, a: attr})
    },
    emitRmEntity() {
      this.$emit('rmEntity', this.entity)
    },
    showIfAdmin() {
      return this.$store.getters.isAdmin
    }
  }
}
</script>
