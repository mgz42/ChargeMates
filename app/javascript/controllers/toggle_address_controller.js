import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="toggle-address"
export default class extends Controller {
  static targets = ["smalla", "biga"]

  toggle (){
    this.smallaTarget.classList.toggle("d-none");
    this.bigaTarget.classList.toggle("d-none")
  }

}
