import firebase from "firebase/compat/app"
import "firebase/compat/auth"

const firebaseConfig = {
  apiKey: process.env.apiKey,
  authDomain: process.env.authDomain,
  databaseURL: process.env.databaseURL,
  projectId: process.env.projectId,
  storageBucket: process.env.storageBucket,
  messagingSenderId: process.env.messagingSenderId,
  appId: process.env.appId,
}

if (!firebase.apps.length) {
  firebase.initializeApp(firebaseConfig)
}

export default firebase
