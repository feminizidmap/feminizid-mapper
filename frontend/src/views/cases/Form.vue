<template>
<div class="codelists container-fluid">
  <div class="row">
    <router-link to="/cases">Übersicht</router-link>
  </div>
  <hr>
  <div class="row my-2">
    <div class="col col-2">
            @todo maybe put tentative identifier here?
      <nav>
        <ul class="nav flex-column">
          <li class="nav-item">
            <router-link :to="{ name: 'CaseNewMeta' }" class="nav-link active" aria-current="page">Quellen</router-link>
          </li>
          <li class="nav-item">
            <router-link :to="{ name: 'CaseNewCrime' }" class="nav-link active" aria-current="page">Tat</router-link>
          </li>
          <li class="nav-item">
            <router-link :to="{ name: 'CaseNewVictim' }" class="nav-link active" aria-current="page">Opfer</router-link>
          </li>
          <li class="nav-item">
            <router-link :to="{ name: 'CaseNewPerpetrator' }" class="nav-link active" aria-current="page">Täter</router-link>
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
  name: 'CaseForm',
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
