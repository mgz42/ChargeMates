import { Controller } from "@hotwired/stimulus"


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

  updateBooking(newDuration) {
    console.log("coucou3")
    const bookingId = this.element.dataset.bookingId;
    const csrfToken = document.querySelector('meta[name="csrf-token"]').getAttribute('content');
    fetch(`/bookings/${bookingId}`, {
      method: "PATCH",
      headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
        "X-CSRF-Token": csrfToken
      },
      body: JSON.stringify({ duree_recharge: newDuration })
    }).then(response => {
      console.log("coucou4")
      if (!response.ok) {
        console.error("Une erreur s'est produite lors de la mise à jour de la durée de réservation.");
      }
      console.log("coucou5")
    }).catch(error => {
      console.error("Erreur lors de la mise à jour de la durée de réservation:", error);
    });
  }


}
