import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["address", "button"];

  getPosition(event) {
    event.preventDefault();
    if (navigator.geolocation) {
      navigator.geolocation.getCurrentPosition(
        (position) => {
          const { latitude, longitude } = position.coords;
          //this.addressAutocompleteTarget.value = "Your position has been set";
          this.addressTarget.value = `${latitude},${longitude}`;
          this.addressTarget.readOnly = true;
          this.buttonTarget.disabled = true;
          const input = document.querySelector(".mapboxgl-ctrl-geocoder--input");
          input.value = `${latitude},${longitude}`;
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
