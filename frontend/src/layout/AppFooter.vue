<template>
  <footer class="border-top border-5 mt-auto border-dark">
    <div class="container-fluid">
      <div class="row row-cols-4 pt-3 pb-1">
        <div>
          <p>Mapper is a software project developed and used by <a href="#">Feminizidmap.org</a>.</p>
          <p>It is Free Software under the AGPL 3 or later License. The sourcecode is available on <a :href="homepage">GitHub</a>.</p>
          <p>Installation and usage guides can be found on <a :href="homepage">tech.feminizidmap.org</a>.</p>
        </div>
        <div class="">
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
      <div class="row border-top border-5 border-dark pt-3 pb-1 text-center bg-dark text-light">
        <p>{{ toolName}} {{ version }}</p>
        <p><a href="">⇪ {{ $t('layout.totop')}}</a></p>
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
