import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="form"
export default class extends Controller {
  static targets = ['hashb'];

  submitForm(e) {
    e.preventDefault()
  }
}
