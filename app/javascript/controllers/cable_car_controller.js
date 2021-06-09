import { Controller } from 'stimulus'
import CableReady from 'cable_ready'

export default class extends Controller {
  connect() {
    console.log("Connect!")
    this.element.addEventListener("ajax:complete", this.perform.bind(this))
  }

  // fetch () {
  //   fetch('/fetch.json', {
  //     headers: { 'X-Requested-With': 'XMLHttpRequest' }
  //   })
  //     .then(response => response.json())
  //     .then(data => CableReady.perform(data))
  // }

  perform(event) {
    console.log("Performing", event)
    CableReady.perform(JSON.parse(event.detail[0].responseText))
  }

  alert(event) {
    console.log("Hi!", event)
  }
}
