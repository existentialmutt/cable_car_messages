import { Controller } from 'stimulus'
import CableReady from 'cable_ready'

export default class extends Controller {
  connect () {
    console.log('Connect!')
    this.element.addEventListener('ajax:success', this.perform)
  }

  disconnect () {
    this.element.removeEventListener('ajax:success', this.perform)
  }

  perform = event => {
    console.log('Performing', event)
    event.detail.response
      .json()
      .then(operations => CableReady.perform(operations))
  }
}
