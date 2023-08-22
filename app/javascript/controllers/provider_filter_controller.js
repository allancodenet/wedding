import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="provider-filter"
export default class extends Controller {
  connect() {
    console.log("hello")
  }
}
