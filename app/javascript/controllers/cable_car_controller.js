import { Controller } from 'stimulus'
import CableReady from 'cable_ready'

export default class extends Controller {
  connect() {
    console.log("Connect!")
    this.element.addEventListener("ajax:complete", this.perform.bind(this))
  }

  perform(event) {
    console.log("Performing", event)
    event.detail.response.json().then(operations => CableReady.perform(operations))
  }

  alert(event) {
    console.log("Hi!", event)
  }
}
