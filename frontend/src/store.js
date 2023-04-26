import { createStore } from 'vuex'
import createPersistedState from 'vuex-persistedstate'
import { securedAxiosInstance } from './backend/axios'

export const store = createStore({
  state() {
    return {
      alerts: [],
      currentUser: {},
      signedIn: false,
      csrf: null,
      categories: [],
      category_items: [],
      //codelists: [],
      records: [],
      currentRecord: {},
      currentRecordHistory: [],
      currentRecordNew: false,
      schema: [],
      schemaHasChanged: false,
      settings: []
    }
  },
  mutations: {
    setCurrentUser(state, { currentUser, csrf }) {
      state.currentUser = currentUser
      state.signedIn = true
      state.csrf = csrf
    },
    unsetCurrentUser(state) {
      state.currentUser = {}
      state.signedIn = false
      state.csrf = null
    },
    refresh(state, csrf) {
      state.signedIn = true
      state.csrf = csrf
    },
    setRecords(state, list) {
      state.records = list
    },
    addToRecords(state, item) {
      state.records.push(item)
    },
    removeSingleRecord(state, item) {
      state.records.splice(state.records.indexOf(item), 1)
    },
    updateSingleRecord(state, item) {
      state.records = [
        ...state.records.filter(element => element.id !== item.id),
        item
      ]
    },
    setCategories(state, list) {
      state.categories = list
    },
    addSingleCategory(state, item) {
      state.categories.push(item)
    },
    removeSingleCategory(state, item) {
      state.categories.splice(state.categories.indexOf(item), 1)
    },
    updateSingleCategory(state, item) {
      state.categories = [
        ...state.categories.filter(element => element.id !== item.id),
        item
      ]
    },
    setCategoryItems(state, list) {
      state.category_items = list
    },
    addSingleCategoryItem(state, item) {
      state.category_items.push(item)
    },
    removeSingleCategoryItem(state, item) {
      state.category_items.splice(state.category_items.indexOf(item), 1)
    },
    updateSingleCategoryItem(state, item) {
      state.category_items = [
        ...state.category_items.filter(element => element.id !== item.id),
        item
      ]
    },
    addAlert(state, item) {
      //state.alerts.push(item)
      state.alerts = [item]
    },
    removeAlert(state, item) {
      state.alerts.splice(state.alerts.indexOf(item), 1)
    },
    pushCurrentRecordHistory(state, item) {
      state.currentRecordHistory.push(item)
    },
    clearCurrentRecordHistory(state) {
      state.currentRecordHistory = []
    },
    setCurrentRecord(state, item) {
      state.currentRecord = item
    },
    setCurrentRecordNew(state, value) {
      state.currentRecordNew = value
    },
    setCurrentRecordProperty(state, propValue) {
      state.currentRecord[propValue.prop] = propValue.value
    },
    clearCurrentRecord(state) {
      state.currentRecord = {}
    },
    setSchema(state, value) {
      state.schema = value
    },
    setSettings(state, value) {
      state.settings = value
    },
    setSchemaHasChanged(state, value) {
      state.schemaHasChanged = value
    }
  },
  getters: {
    isAdmin(state) {
      return state.currentUser && state.currentUser.role === 'admin'
    },
    isManager(state) {
      return state.currentUser && state.currentUser.role === 'reviewer'
    },
    currentUserId(state) {
      return state.currentUser && state.currentUser.id
    },
    getRecordById: (state) => (id) => {
      return state.records.find(record => record.id == id)
    },
    getCategoryById: (state) => (catID) => {
      return state.categories.find(c => c.id === catID)
    },
    getItemsForCategory: (state) => (category) => {
      return state.category_items.filter(i => i.category_id === category.id)
    },
    isSignedIn(state) {
      return state.signedIn
    },
    allAlerts(state) {
      return state.alerts
    },
    isCurrentRecordEmpty(state) {
      return Object.entries(state.currentRecord).length === 0
    },
    isCurrentRecordNew(state) {
      return state.currentRecordNew;
    },
    getSetting: (state) => (setting) => {
      return state.settings?.find(s => s.key === setting)
    },
    hasStoreLocalChange(state) {
      return Object.keys(state.schema).length !== 0
    },
    getEntityValue: (state) => (entityName, key, type) => {
      const entity = state.currentRecord.entities?.find(entity => entity.name === entityName)
      if (entity) {
        if (type === 'field') {
          const field = entity.fields?.find(field => field.name === key)
          if (field) {
            return field.value
          }
        } else if (type === 'category') {
          const category = entity.properties?.find(property => property.name === key)
          if (category) {
            return category.value
          }
        }
      }
      return null
    }
  },
  actions: {
    fetchRecords({ commit }) {
      securedAxiosInstance.get('/records')
        .then(response => {
          commit('setRecords', response.data)
        })
        .catch(error => {
          const e = (error.response && error.response.data && error.response.data.error) || 'Something went wrong while loading records.'
          commit('addAlert', { type: 'error', message: e})
        })
    },
    loadRecord({ commit }, recordId) {
      securedAxiosInstance.get(`/records/${recordId}`)
        .then(response => {
          const record = response.data
          commit('setCurrentRecord', response.data)
        })
        .catch(error => {
          const e = (error.response && error.response.data && error.response.data.error) || `Something went wrong while loading the record #${recordId}.`;
          commit('addAlert', { type: 'error', message: e})
        })
    }
  },
  plugins: [createPersistedState()]
})
