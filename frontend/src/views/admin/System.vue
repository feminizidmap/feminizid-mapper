<template>
<div class="container-fluid">
  <header class="row">
    <h2 class="h1">{{ $t('admin.system.title') }}</h2>
    <p class="fs-5">{{ $t('admin.system.blurb')}}</p>
    <hr>
  </header>
  <div class="row">
    <section v-for="setting in settings" :key="setting.id" class="my-4">
      <h2 class="h2">{{setting.key}}</h2>
      <div><code>{{setting.value}}</code></div>
    </section>
  </div>
</div>
</template>
<script>
export default {
  name: 'AdminSystem',
  computed: {
    settings() {
      return this.$store.state.settings
    }
  }
}
</script>
