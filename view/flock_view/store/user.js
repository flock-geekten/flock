import axios from 'axios'

export const state = () => ({
  loggedIn: false,
  uid: '',
})

export const mutations = {
  login(state) {
    state.loggedIn = true
  },
  logout(state) {
    state.loggedIn = false
  },
  setUid(state, uid) {
    state.uid = uid
  },
  removeUid(state) {
    state.uid = ''
  },
}
