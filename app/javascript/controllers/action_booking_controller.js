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
      { received: data => this.actionTarget.innerHTML = data }
    )
    console.log(`Subscribed to the chatroom with the id ${this.bookingIdValue}.`)
  }

  // #insertPartial() {
  //   if (this.ownerIdValue === this.userIdValue) {
  //     this.actionTarget.innerHTML = <% render :partial => "owner_bookingactions" -%>
  //   } else {
  //     this.actionTarget.innerHTML = `<%= render 'customer_bookingactions', booking: @booking %>`;
  //   };



  // };


}
