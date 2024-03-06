import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["startButton", "stopButton", "countdownTimer", "chargingDuration"]

  connect() {
    // Code exécuté lors de la connexion du contrôleur
  }

  startCharging() {
    // Action pour démarrer la recharge
    console.log("Démarrer la recharge");
    // Mettre à jour l'interface utilisateur, par exemple :
    this.startButtonTarget.disabled = true;
    this.stopButtonTarget.disabled = false;
    this.startCountdown();
  }

  stopCharging() {
    // Action pour arrêter la recharge
    console.log("Arrêter la recharge");
    // Mettre à jour l'interface utilisateur, par exemple :
    this.stopButtonTarget.disabled = true;
    this.startButtonTarget.disabled = false;
    this.displayChargingDuration();
  }

  startCountdown() {
    // Simuler un compte à rebours de 10 secondes
    let secondsLeft = 10;
    const timer = setInterval(() => {
      secondsLeft--;
      this.countdownTimerTarget.textContent = `Temps restant : ${secondsLeft} secondes`;
      if (secondsLeft === 0) {
        clearInterval(timer);
        this.stopCharging();
      }
    }, 1000);
  }

  displayChargingDuration() {
    // Afficher la durée de recharge
    const duration = 2.5; // Exemple de durée de recharge
    this.chargingDurationTarget.textContent = `Durée de recharge : ${duration} heures`;
  }
}
