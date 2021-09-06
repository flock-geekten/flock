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
    state.userId = user.id
    state.userName = user.name
  },
  removeUser(state) {
    state.user = ''
    state.userId = ''
    state.userName = ''
  }
}
