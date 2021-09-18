import axios from 'axios'

export const state = () => ({
  loggedIn: false,
	googleLoggedIn: false,
  uid: '',
  user: '',
  userId: '',
  userName: '',
	userImg: '',
})

export const mutations = {
  login(state) {
    state.loggedIn = true
  },
  logout(state) {
    state.loggedIn = false
  },
  googleLoggedIn(state) {
    state.googleLoggedIn = true
  },
  googleLoggedOut(state) {
    state.googleLoggedIn = false
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
	setUserImg(state, userImg){
		state.userImg = userImg
	},
  removeUserImg(state) {
    state.userImg = ''
  },
}
