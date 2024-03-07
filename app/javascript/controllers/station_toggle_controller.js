import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="station-toggle"
export default class extends Controller {
  connect() {
    console.log("connecté !")
  }
}
