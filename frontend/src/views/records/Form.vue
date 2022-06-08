<template>
<div class="codelists container-fluid">
  <div class="row">
    <router-link to="/records">Übersicht</router-link>
  </div>
  <hr>
  <div class="row my-2">
    <div class="col col-2">
      <div>
        <span class="">{{}}</span>
        <span>@todo explain what the identifier is/ does</span>
      </div>
      <nav>
        <ul class="nav flex-column">
          <li class="nav-item">
            <router-link :to="{ name: 'RecordNewMeta' }" class="nav-link active" aria-current="page">Quellen</router-link>
          </li>
          <li class="nav-item">
            <router-link :to="{ name: 'RecordNewCrime' }" class="nav-link active" aria-current="page">Tat</router-link>
          </li>
          <li class="nav-item">
            <router-link :to="{ name: 'RecordNewVictim' }" class="nav-link active" aria-current="page">Opfer</router-link>
          </li>
          <li class="nav-item">
            <router-link :to="{ name: 'RecordNewPerpetrator' }" class="nav-link active" aria-current="page">Täter</router-link>
          </li>
        </ul>
      </nav>

    </div>
    <div class="col col-7">
      <router-view></router-view>
    </div>
    <div class="col col-3">
      @todo maybe put changes history here?
    </div>
  </div>
</div>
</template>
<script>


export default {
  name: 'RecordForm',
  data() {
    return {

    }
  },
  created() {

  },
  methods: {
  }
}
</script>
