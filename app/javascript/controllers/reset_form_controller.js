import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="reset-form"
export default class extends Controller {
  static targets = ["input"];
  connect() {
  }
  clearInput() {
    this.inputTarget.value = "";
  }
}
