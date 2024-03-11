import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="toggle-historic"
export default class extends Controller {
  static targets = ["bouton", "ladiv"]
  connect() {
  }

  toggle_historic(){
    this.boutonTarget.innerHTML === '<i class="fa-solid fa-chevron-down"></i>' ? this.boutonTarget.innerHTML = '<i class="fa-solid fa-chevron-up"></i>' : this.boutonTarget.innerHTML =  '<i class="fa-solid fa-chevron-down"></i>';
    this.ladivTarget.classList.toggle("d-none");
  }

}
