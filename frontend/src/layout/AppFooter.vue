<template>
  <footer class="border-top border-5 mt-auto">
    <div class="container-fluid">
      <div class="row row-cols-4 py-3">
        <div class="">
          <p><a :href="homepage">{{ toolName }}</a></p>
          <p>{{ version }}</p>
        </div>
        <div>

        </div>
        <div></div>
        <div>
          <label for="lang-switch"
                 class="form-label">{{ $t('forms.changeLang') }}</label>
          <select id="lang-switch"
                  class="form-select"
                  v-model="$i18n.locale">
            <option value="en">English</option>
            <option value="de">Deutsch</option>
          </select>
        </div>
      </div>
      <div class="row border-top border-5 py-3 text-center">
        <a href="">to top</a>
      </div>
    </div>
  </footer>
</template>
<script>
 import { version, name, homepage } from '../../package.json'

 export default {
   name: "AppFooter",
   computed: {
     version() {
       return `version ${version}`
     },
     toolName() {
       return name
     },
     homepage() {
       return homepage
     }
   }
 }
</script>
