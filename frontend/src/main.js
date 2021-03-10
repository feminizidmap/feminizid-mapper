import { createApp } from 'vue'
import App from './App.vue'
import VueAxios from 'vue-axios'
//import axios from './backend/axios'
import { securedAxiosInstance, plainAxiosInstance } from './backend/axios'
import router from './router'

const app = createApp(App)
app.use(router)
app.use(VueAxios, {
    secured: securedAxiosInstance,
    plain: plainAxiosInstance
})
app.mount('#app')
