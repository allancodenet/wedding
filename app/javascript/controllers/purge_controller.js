import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="purge"
export default class extends Controller {
  static targets = ["image"]

  delete() {

    console.log("hello");
  }

}
