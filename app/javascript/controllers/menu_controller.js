import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="menu"
export default class extends Controller {
  static targets = ["leftMenu", "rightMenu", "mainContent", "leftBurger", "rightBurger"];

  connect() {
    this.leftMenu = document.getElementById("left-menu");
    this.rightMenu = document.getElementById("right-menu");
    this.mainContent = document.getElementById("main-content");
  }

  openLeftMenu(event) {
    event.preventDefault();
    this.leftMenu.classList.add("open");
    this.mainContent.classList.add("shift-left");
    this.hideButton(event.currentTarget);
  }

  closeLeftMenu() {
    this.leftMenu.classList.remove("open");
    this.mainContent.classList.remove("shift-left");
    this.showButton(this.leftBurgerTarget);
  }

  openRightMenu(event) {
    event.preventDefault();
    this.rightMenu.classList.add("open");
    this.mainContent.classList.add("shift-right");
    this.hideButton(event.currentTarget);
  }

  closeRightMenu() {
    this.rightMenu.classList.remove("open");
    this.mainContent.classList.remove("shift-right");
    this.showButton(this.rightBurgerTarget);
  }

  hideButton(button) {
    button.classList.add("d-none");
  }

  showButton(button) {
    button.classList.remove("d-none");
  }
}
