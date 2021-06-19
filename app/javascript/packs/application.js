// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import 'bootstrap/dist/css/bootstrap.min.css'
import CableReady from 'cable_ready'

import mrujs from 'mrujs'
window.mrujs = mrujs.start()

import Turbolinks from "turbolinks"
Turbolinks.start()

document.addEventListener('ajax:success', async event => {
  CableReady.perform(await event.detail.fetchResponse.responseJson)
})

document.addEventListener('ajax:error', async event => {
  alert("Sorry, an error ocurred. Please reload the page and try again.")
  console.log(await event.detail.fetchResponse.responseText)
})
