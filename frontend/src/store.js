import { createStore } from 'vuex'
import createPersistedState from 'vuex-persistedstate'

export const store = createStore({
  state() {
    return {
      alerts: [],
      currentUser: {},
      signedIn: false,
      csrf: null,
      codelists: [],
      codelistItems: [],
      systemSettings: [],
      cases: []
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
      console.log(list, state.cases)
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
    setCodelists(state, list) {
      state.codelists = list
    },
    removeSingleCodelist(state, item) {
      state.codelists.splice(state.codelists.indexOf(item), 1)
    },
    addToCodelist(state, item) {
      state.codelists.push(item)
    },
    updateSingleCodelist(state, item) {
      state.codelists = [
        ...state.codelists.filter(element => element.id !== item.id),
        item
      ]
    },
    setCodelistItems(state, list) {
      state.codelistItems = list
    },
    removeSingleCodelistItem(state, item) {
      state.codelistItems.splice(state.codelistItems.indexOf(item), 1)
    },
    addToCodelistItems(state, item) {
      state.codelistItems.push(item)
    },
    updateSingleCodelistItem(state, item) {
      state.codelistItems = [
        ...state.codelistItems.filter(element => element.id !== item.id),
        item
      ]
    },
    addAlert(state, item) {
      //state.alerts.push(item)
      state.alerts = [item]
    },
    removeAlert(state, item) {
      state.alerts.splice(state.alerts.indexOf(item), 1)
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
      const item = state.cases.filter(x => x.id === id)
      return item.length > 0 ? item[0] : null
    },
    isCodelistsEmpty(state) {
      return state.codelists.length === 0
    },
    getCodelistById: (state) => (id) => {
      const item = state.codelists.filter(x => x.id === id)
      return item.length > 0 ? item[0] : null
    },
    getCodelistsByIdent: (state) => (ident) => {
      return state.codelists.filter(x => x.identifier === ident)
    },
    getCodelistsByIdentAndLang: (state) => (ident, lang) => {
      return state.codelists
        .filter(x => x.identifier == ident)
        .filter(x => x.lang == lang)
    },
    getCodelistItemsByListId: (state) => (id) => {
      return state.codelistItems.filter(x => x.codelist_id === id)
    },
    getCodelistItemsByIdentAndLang: (state) => (ident, lang) => {
      return state.codelistItems
        .filter(x => x.identifier == ident)
        .filter(x => x.lang == lang)
    },
    getCodelistItemsByIdent: (state) => (ident) => {
      return state.codelistItems.filter(x => x.identifier === ident)
    },
    getCodelistItemById: (state) => (id) => {
      const item = state.codelistItems.filter(x => x.id === id)
      return item.length > 0 ? item[0] : null
    },
    isSignedIn(state) {
      return state.signedIn
    },
    allAlerts(state) {
      return state.alerts
    }
  },
  plugins: [createPersistedState()]
})
