import { createStore } from 'vuex'
import createPersistedState from 'vuex-persistedstate'

export const store = createStore({
    state() {
        return {
            currentUser: {},
            signedIn: false,
            csrf: null,
            codelists: []
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
        setCodelists(state, list) {
            state.codelists = list
        },
        removeCodelistItem(state, item) {
            state.codelists.splice(state.codelists.indexOf(item), 1)
        },
        addToCodelist(state, item) {
            state.codelists.push(item)
        },
        updateCodelistItem(state, item) {
            state.codelists = [
                ...state.codelists.filter(element => element.id !== item.id),
                item
            ]
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
        isCodelistsEmpty(state) {
            return state.codelists.length === 0
        }
    },
    plugins: [createPersistedState()]
})
