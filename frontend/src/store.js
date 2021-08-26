import { createStore } from 'vuex'
import createPersistedState from 'vuex-persistedstate'

export const store = createStore({
  state() {
    return {
      alerts: [],
      currentUser: {},
      signedIn: false,
      csrf: null,
      categories: [],
      category_items: [],
      systemSettings: [],
      cases: [],
      newCase: {},
      newCaseHistory: [],
      schema: [],
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
    setCases(state, list) {
      state.cases = list
    },
    addToCases(state, item) {
      state.cases.push(item)
    },
    removeSingleCase(state, item) {
      state.cases.splice(state.cases.indexOf(item), 1)
    },
    updateSingleCase(state, item) {
      state.cases = [
        ...state.cases.filter(element => element.id !== item.id),
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
    pushNewCaseHistory(state, item) {
      state.newCaseHistory.push(item)
    },
    clearNewCaseHistory(state) {
      state.newCaseHistory = []
    },
    setNewCase(state, item) {
      state.newCase = item
    },
    setNewCaseProperty(state, propValue) {
      state.newCase[propValue.prop] = propValue.value
    },
    clearNewCase(state) {
      state.newCase = {}
    },
    setSchema(state, value) {
      state.schema = value
    },
    setSettings(state, value) {
      state.settings = value
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
    getCaseById: (state) => (id) => {
      //const item = state.cases.filter(x => x.id === id)
      //return item.length > 0 ? item[0] : null
      return state.cases.find(fcase => fcase.id == id)
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
    isNewCaseEmpty(state) {
      return Object.entries(state.newCase).length === 0
    },
    getSetting: (state) => (setting) => {
      return state.settings?.find(s => s.key === setting)
    }
  },
  plugins: [createPersistedState()]
})
