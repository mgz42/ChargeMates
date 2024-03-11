import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="preloader"
export default class extends Controller {
  static targets = ["introscreen"];
  connect() {
    if (document.readyState !== "interactive"){
      this.introscreenTarget.classList.add("d-none");
    }

  }

  getout() {
    this.introscreenTarget.classList.add("animate");
    setTimeout(() => {
      this.introscreenTarget.classList.add("d-none");
    }, 1100);
  }
}
