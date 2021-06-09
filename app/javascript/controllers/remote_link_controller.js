import { Controller } from "stimulus"

export default class extends Controller {
  fetch(event) {
    event.preventDefault()
    window.mrujs.fetch({
      url: this.element.href,
      "Accept": "application/json"
    }).then( (response) =>{
      console.log(response)
        const completeEvent = new CustomEvent("ajax:complete", {
          detail: {response: response},
          bubbles: true
        })
        console.log(completeEvent.bubbles, "bubbles")
          document.querySelector("body").dispatchEvent(completeEvent)
        }
    )
  }
}
