import { Controller } from "@hotwired/stimulus"
import { createConsumer } from "@rails/actioncable"



export default class extends Controller {
  static values = { chatMateId: Number }

  connect() {
    this.channel = consumer.subscriptions.create(
      { channel: "TchatMateChannel", tchat_mate_id: this.chatMateIdValue },
      {
        received: (data) => {
          this._insertMessage(data.message);
        }
      }
    );
  }

  disconnect() {
    if (this.channel) {
      this.channel.unsubscribe();
    }
  }

  _insertMessage(message) {
    // Insérer le message dans le DOM
    console.log(message);
  }
}
