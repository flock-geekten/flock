import firebase from '~/plugins/firebase'

export default function({ route, redirect }){
  firebase.auth().onAuthStateChanged(function(user){
    if (user) {
      // User is signed in
    } else {
      // No user is signed in.
      if (route.path !== '/login') {
        redirect('/login')
      }
    }
  });
}
