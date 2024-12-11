import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="menu"
export default class extends Controller {
  static targets = ["leftMenu", "rightMenu", "mainContent"];

  connect() {
    this.leftMenu = document.getElementById("left-menu");
    this.rightMenu = document.getElementById("right-menu");
    this.mainContent = document.getElementById("main-content");
  }

  openLeftMenu() {
    this.leftMenu.classList.add("open");
    this.mainContent.classList.add("shift-left");
  }

  closeLeftMenu() {
    this.leftMenu.classList.remove("open");
    this.mainContent.classList.remove("shift-left");
  }

  openRightMenu() {
    this.rightMenu.classList.add("open");
    this.mainContent.classList.add("shift-right");
  }

  closeRightMenu() {
    this.rightMenu.classList.remove("open");
    this.mainContent.classList.remove("shift-right");
  }
}
