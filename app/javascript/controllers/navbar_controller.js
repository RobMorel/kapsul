import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["toggleBtn", "navbar"];

  connect() {
    this.navbarVisible = true; // Initialise la navbar comme visible
  }

  toggleNavbar() {
    this.navbarVisible = !this.navbarVisible; // Alterne la visibilité

    // Alterner la classe 'hidden' sur la navbar
    this.navbarTarget.classList.toggle("hidden", !this.navbarVisible);

    // Changer l'icône en fonction de l'état
    const icon = this.toggleBtnTarget.querySelector("i");
    if (this.navbarVisible) {
      console.log("Navbar visible, flèche vers le haut"); // Vérifier dans la console
      icon.classList.remove("fa-chevron-down");
      icon.classList.add("fa-chevron-up");
      this.toggleBtnTarget.classList.remove("move-up");
      this.toggleBtnTarget.classList.add("down");
    } else {
      console.log("Navbar cachée, flèche vers le bas"); // Vérifier dans la console
      icon.classList.remove("fa-chevron-up");
      icon.classList.add("fa-chevron-down");
      this.toggleBtnTarget.classList.remove("up");
      this.toggleBtnTarget.classList.add("move-up");
    }
  }
}
