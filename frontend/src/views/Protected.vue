<template>
  <div class="protected">
    <router-view></router-view>
  </div>
</template>

<script>
 export default {
  name: 'Protected',
  created () {
    if (!this.$store.state.signedIn) {
      this.$router.replace('/signin')
    }
  }
}
</script>
