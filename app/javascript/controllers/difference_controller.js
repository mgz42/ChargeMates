import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["arrivee", "depart", "difference"]

  connect() {
    this.calculateDifference()
  }

  calculateDifference() {
    if (this.hasArriveeTarget && this.hasDepartTarget && this.arriveeTarget.value && this.departTarget.value) {
      const dateArrivee = new Date(this.arriveeTarget.value)
      const dateDepart = new Date(this.departTarget.value)
      const differenceMilliseconds = dateDepart - dateArrivee
      const differenceHeures = differenceMilliseconds / (1000 * 60 * 60)

      this.differenceTarget.textContent = `Différence: ${differenceHeures.toFixed(2)} heures`
    } else {
      this.differenceTarget.textContent = "Veuillez sélectionner des dates valides"
    }
  }
}
