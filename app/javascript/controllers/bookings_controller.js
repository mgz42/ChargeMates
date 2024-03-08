import { Controller } from "@hotwired/stimulus"
import flatpickr from "flatpickr";

export default class extends Controller {
  static targets = ["duration"]

  connect() {
    console.log("coucouBenoitleboulet")
  }


  updateDuration(event) {
    console.log("coucou1")
    const value = parseFloat(event.target.dataset.value);
    const currentDuration = parseFloat(this.durationTarget.textContent);
    const newDuration = currentDuration + value;
    if (newDuration >= 0) {
      this.durationTarget.textContent = newDuration;
      this.updateBooking(newDuration);
      console.log("coucou2")
    }


    }


}
