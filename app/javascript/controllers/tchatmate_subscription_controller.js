import { Controller } from "@hotwired/stimulus"
import { createConsumer } from "@rails/actioncable"

export default class extends Controller {
  static values = {
    bookingId: Number
  }
  static targets = ["messages"]

  connect() {
    console.log("Connected to the Stimulus controller.");

    this.channel = createConsumer().subscriptions.create(
      { channel: "TchatMateChannel", id: this.bookingIdValue },
      {
        received: (data) => {
          this.#insertMessageAndScrollDown(data);
        }
      }
    );
  }
  #insertMessageAndScrollDown(data) {
    this.messagesTarget.insertAdjacentHTML("beforeend", data);
    const lastMessage = this.messagesTarget.lastElementChild;
    setTimeout(() => lastMessage.scrollIntoView({ behavior: 'smooth', block: 'end' }), 100);
  }


  disconnect() {
    if (this.channel) {
      this.channel.unsubscribe();
      console.log("Disconnected from the channel.");
    }
  }

  resetForm(event) {
  event.target.reset()
}

  _insertMessage(message) {
    // Insérer le message dans le DOM
    console.log("Received a message:", message);
  }
}
