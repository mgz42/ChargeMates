import { Controller } from "@hotwired/stimulus"
export default class extends Controller {
  static targets = ["modelSelect"]
  updateModels(event) {
    const selectedBrand = event.target.value;
    // console.log("Selected brand:", selectedBrand);
    // console.log(this.modelSelectTarget)
    if (selectedBrand) {
      fetch(`/vehicles/get_models_by_brand?brand=${selectedBrand}`)
        .then(response => response.json())
        .then(data => {
          // je nettoie le html contenu dans la balise html select (this.modelSelectTarget)
          this.modelSelectTarget.innerHTML = '';
          // pour chaque nom de model contenu dans l'array data
          data.forEach(model => {
            // je créé une balise html "options" que je stock dans une variable
            const option = document.createElement('option');
            // j'insère cette variable dans ma target input select (this.modelSelectTarget)
            // Assigner la valeur du modèle à l'option
            option.value = model;
            // Assigner le texte du modèle à l'option
            option.textContent = model;
            // Insérer l'option dans la balise select (this.modelSelectTarget)
            this.modelSelectTarget.appendChild(option);
        })
      });
    } else {
      console.error('Selected brand is null or undefined');
    }
  }
}
