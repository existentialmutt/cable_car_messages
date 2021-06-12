import { Controller } from 'stimulus'
import CableReady from 'cable_ready'

export default class extends Controller {
  connect() {
    console.log("Connect!")
    this.boundPerform = this.perform.bind(this)
    this.element.addEventListener("ajax:success", this.boundPerform)
  }

  perform(event) {
    console.log("Performing", event)
    event.detail.response.json().then(operations => {
      CableReady.perform(operations)
      window.mrujs.restart()
    })
  }

  disconnect() {
    this.element.removeEventListener("ajax:success", this.boundPerform)
  }
}
