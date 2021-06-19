// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import 'bootstrap/dist/css/bootstrap.min.css'
import CableReady from 'cable_ready'

// import Rails from "@rails/ujs"
// Rails.start()

import mrujs from 'mrujs'
window.mrujs = mrujs.start()

// import Turbolinks from "turbolinks"
// Turbolinks.start()

document.addEventListener('ajax:success', event => {
  console.log('Performing', event)
  event.detail.response
    .json()
    .then(operations => CableReady.perform(operations))
})

// stimulus
// import { Application } from "stimulus"
// import { definitionsFromContext } from "stimulus/webpack-helpers"

// const application = Application.start()
// const context = require.context("../controllers", true, /\.js$/)
// application.load(definitionsFromContext(context))
