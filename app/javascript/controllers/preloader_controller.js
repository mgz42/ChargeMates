import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="preloader"
export default class extends Controller {
  static targets = ["introscreen"];
  connect() {
    // if (window.location.href !== "http://localhost:3000/" ){
    //   this.introscreenTarget.classList.add("d-none");
    // }
    // console.log(window.location.href)
  }

  getout() {
    this.introscreenTarget.classList.add("animate");
    setTimeout(() => {
      this.introscreenTarget.classList.add("d-none");
    }, 1100);
  }
}
