<template>
<div class="container-fluid">
  <header class="row">
    <h2 class="h1">{{ $t('admin.system') }}</h2>
    <p class="fs-5">Here is some text about the system settings.</p>
    <hr>
  </header>
  <div class="row mt-5">
    <section v-for="setting in settings" :key="setting.id">
      <h2 class="h2">{{setting.key}}</h2>
      <div><code>{{setting.value}}</code></div>
      <div class="mt-3">
        <router-link :to="`/admin/${setting.key}`" class="btn btn-outline-primary">Change this setting</router-link>
      </div>
    </section>
  </div>
</div>
</template>
<script>
export default {
  name: 'AdminSystem',
  data() {
    return {
      settings: []
    }
  },
  created() {
    this.$http.secured.get('/system_settings')
      .then(resp => {
        this.settings.push(resp.data.reverse()[0])
      })
      .catch(e => console.log(e))
  }
}
</script>
