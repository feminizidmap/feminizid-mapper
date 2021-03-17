import { createApp } from 'vue'
import App from './App.vue'
import VueAxios from 'vue-axios'
//import axios from './backend/axios'
import { securedAxiosInstance, plainAxiosInstance } from './backend/axios'
import router from './router'
import { store } from './store'
import { i18n } from './i18n'

const app = createApp(App)
      .use(router)
      .use(store)
      .use(i18n)
      .use(VueAxios, {
          secured: securedAxiosInstance,
          plain: plainAxiosInstance
      })
app.mount('#app')
