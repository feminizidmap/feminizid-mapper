import { createStore } from 'vuex'
import createPersistedState from 'vuex-persistedstate'

export const store = createStore({
    state() {
        return {
            currentUser: {},
            signedIn: false,
            csrf: null
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
        }
    },
    getters: {
        isAdmin(state) {
            return state.currentUser && state.currentUser.role === 'admin'
        },
        isManager(state) {
            return state.currentUser && state.currentUser.role === 'reviewer'
        }
    },
    plugins: [createPersistedState()]
})
