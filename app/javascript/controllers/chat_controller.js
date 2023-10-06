import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="chat"
export default class extends Controller {
  connect() {
    this.element.addEventListener("turbo:stream:after-append", (event) => {
      // Scroll to the bottom of the chat window to display the new message
      this.element.scrollTop = this.element.scrollHeight;
    })
  }

}
