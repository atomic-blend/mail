importScripts("https://www.gstatic.com/firebasejs/9.10.0/firebase-app-compat.js");
importScripts("https://www.gstatic.com/firebasejs/9.10.0/firebase-messaging-compat.js");

firebase.initializeApp({
    apiKey: "AIzaSyC6Nrq1lY7AGrmcdWyM7QErHFnYJeG86HA",
    authDomain: "atomic-blend-prod.firebaseapp.com",
    projectId: "atomic-blend-prod",
    storageBucket: "atomic-blend-prod.firebasestorage.app",
    messagingSenderId: "840843408515",
    appId: "1:840843408515:web:b235cf9fae491459a257b6",
    measurementId: "G-B5GQN9YGE8"
});
// Necessary to receive background messages:
const messaging = firebase.messaging();
