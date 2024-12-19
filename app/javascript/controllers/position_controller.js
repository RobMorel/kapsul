import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["address", "button"];

  getPosition(event) {
    event.preventDefault();
    if (navigator.geolocation) {
      navigator.geolocation.getCurrentPosition(
        (position) => {
          const { latitude, longitude } = position.coords;
          //this.addressTarget.value = "Your position has been set";
          this.addressTarget.value = `${latitude},${longitude}`;
          this.addressTarget.readOnly = true;
          this.buttonTarget.disabled = true;
        },
        (error) => {
          console.error("Error obtaining position:", error);
          alert("Unable to retrieve your location. Please try again.");
        }
      );
    } else {
      alert("Geolocation is not supported by your browser.");
    }
  }
}
