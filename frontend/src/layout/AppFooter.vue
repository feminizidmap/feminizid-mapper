<template>
  <footer>
    <div>
      <label for="lang-switch"
             class="visually-hidden form-label">{{ $t('forms.changeLang') }}</label>
      <select id="lang-switch"
              class="form-select"
              v-model="$i18n.locale">
        <option value="en">English</option>
        <option value="de">Deutsch</option>
      </select>
    </div>
  </footer>
</template>
<script>
 export default {
   name: "AppFooter"
 }
</script>
