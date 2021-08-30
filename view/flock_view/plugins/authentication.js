import firebase from '~/plugins/firebase'

export default function({ $axios, route, redirect, store }){
  firebase.auth().onAuthStateChanged(function(user){
    if (user) {
      // User is signed in
      store.commit('user/login')
      const token = user.zaBearer
      $axios.setToken(token, 'Bearer')
    } else {
      // No user is signed in.
      if (route.path !== '/login') {
        redirect('/login')
      }
    }
  });
}
