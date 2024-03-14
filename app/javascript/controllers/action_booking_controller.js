import { Controller } from "@hotwired/stimulus"
import { createConsumer } from "@rails/actioncable"

// Connects to data-controller="action-booking"
export default class extends Controller {
static values = {
  bookingId: Number,
  isOwner: String
}

static targets = ["action"]

  connect() {
    console.log(this.isOwnerValue)
    this.channel = createConsumer().subscriptions.create(
      { channel: "ActionBookingChannel", id: this.bookingIdValue },
      { received: (data) => {
        if (this.isOwnerValue == "owner"){
          this.actionTarget.innerHTML = data["owner"]
        }
        else {
          this.actionTarget.innerHTML = data["customer"]
        }
      } }
    )
    console.log(`Subscribed to the chatroom with the id ${this.bookingIdValue}.`)
  }
}
