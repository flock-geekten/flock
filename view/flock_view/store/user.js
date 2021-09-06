import axios from 'axios'

export const state = () => ({
  loggedIn: false,
  uid: '',
  user: '',
  userId: '',
  userName: '',
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
  setUser(state, user) {
    state.user = user
  },
  removeUser(state) {
    state.user = ''
  },
  setUserId(state, userId) {
    state.userId = userId
  },
  removeUserId(state) {
    state.userId = ''
  },
  setUserName(state, userName) {
    state.userName = userName
  },
  removeUserName(state) {
    state.userName = ''
  },
}
