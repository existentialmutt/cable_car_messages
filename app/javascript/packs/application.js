// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import 'bootstrap/dist/css/bootstrap.min.css'

import Rails from "@rails/ujs"
Rails.start()

// import mrujs from "mrujs";
// window.mrujs = mrujs.start();

import Turbolinks from "turbolinks"
Turbolinks.start()



// stimulus
import { Application } from "stimulus"
import { definitionsFromContext } from "stimulus/webpack-helpers"

const application = Application.start()
const context = require.context("../controllers", true, /\.js$/)
application.load(definitionsFromContext(context))
