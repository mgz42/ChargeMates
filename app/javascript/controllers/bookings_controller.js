import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["duration"]

  updateDuration(event) {
    const value = parseFloat(event.target.dataset.value);
    const currentDuration = parseFloat(this.durationTarget.textContent);
    const newDuration = currentDuration + value;
    if (newDuration >= 0) {
      this.durationTarget.textContent = newDuration;
      this.updateBooking(newDuration);
    }
  }

  updateBooking(newDuration) {
    const bookingId = this.element.dataset.bookingId;
    fetch(`/bookings/${bookingId}`, {
      method: "PATCH",
      headers: {
        "Content-Type": "application/json",
        "Accept": "application/json"
      },
      body: JSON.stringify({ duree_recharge: newDuration })
    }).then(response => {
      if (!response.ok) {
        console.error("Une erreur s'est produite lors de la mise à jour de la durée de réservation.");
      }
    }).catch(error => {
      console.error("Erreur lors de la mise à jour de la durée de réservation:", error);
    });
  }


}
