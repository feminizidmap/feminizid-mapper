<template>
<div class="container-fluid">
  <div class="row">
    <h2 class="h1">{{ $t('layout.schema') }}</h2>
    <p class="fs-5">The schema defines the structure of the data, that means the possible fields on a single record.<br>Think of it as the columns in a spreadsheet.</p>
    <hr>
  </div>
  <div class="row mt-5">
    <div>
      <h3 class="h2">Record</h3>
      <p>Record is a single datum, one entry in your database. Everything starts here.</p>
    </div>
    <div class="mt-4">
      <h4>Entities</h4>
      <p>Entities group logical information together. Usually the entities are Victim, Perpetrator, Crime but you can have more if you want</p>
      <div>
        <button type="btn"
                class="btn btn-primary"
                @click.prevent="addEntityField">Hinzufügen</button>

        <NewEntityItem></NewEntityItem>
        <ul class="mt-4 ms-3 border-start border-4">

          <li class="mt-4">
            <EntityItem></EntityItem>
          </li>
        </ul>
      </div>
    </div>
  </div>
</div>
</template>
<script>
  import EntityItem from '@/components/schema/EntityItem'
  import NewEntityItem from '@/components/schema/NewEntityItem'

export default {
  name: 'Schema',
  components: { EntityItem, NewEntityItem }
}
</script>
