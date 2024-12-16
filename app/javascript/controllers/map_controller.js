import { Controller } from "@hotwired/stimulus"
import mapboxgl from 'mapbox-gl'

// Connects to data-controller="map"
export default class extends Controller {

  static values = {
    apiKey: String,
    markers: Array
  }

  connect() {
    console.log(this.params)
    mapboxgl.accessToken = this.apiKeyValue
    this.map = new mapboxgl.Map({
      container: this.element,
      style: 'mapbox://styles/rob738/cm4nai60l004d01qtaw80cp3z',
    });
  this.#addMarkersToMap();
  this.#fitMapToMarkers();

      // Add geolocate control to the map.
      this.map.addControl(
        new mapboxgl.GeolocateControl({
            positionOptions: {
                enableHighAccuracy: true
            },
            // When active the map will receive updates to the device's location as it changes.
            trackUserLocation: true,
            // Draw an arrow next to the location dot to indicate which direction the device is heading.
            showUserHeading: true,
            showUserLocation: true
        })
    );
  }

  #addMarkersToMap() {
    this.markersValue.forEach((marker) => {
      const popup = new mapboxgl.Popup().setHTML(marker.infoWindow);

      const customMarker = document.createElement("div");
      customMarker.innerHTML = marker.marker_html;

      const mrker = new mapboxgl.Marker(customMarker).setLngLat([marker.lng, marker.lat]).setPopup(popup).addTo(this.map)
      if (this.params.get("openPopup") && (this.params.get("lat") == marker.lat) && (this.params.get("lng") == marker.lng) ) {
        mrker.togglePopup()
      }
    });
  }


  #fitMapToMarkers() {

    const lat = this.params.get('lat');
    const lng = this.params.get('lng');
    const zoom = this.params.get('zoom');

    const bounds = new mapboxgl.LngLatBounds();

    if (lat && lng && zoom) {
      // this.map.flyTo({ center: [lng, lat], zoom: 4, essential: true})
      bounds.extend([lng, lat]);
      this.map.fitBounds(bounds, { padding: 70, maxZoom: zoom, duration: 0 });
    } else {
      this.markersValue.forEach((marker) => {
        bounds.extend([marker.lng, marker.lat]);
      });
      this.map.fitBounds(bounds, { padding: 70, maxZoom: 15, duration: 0 });
    }
  }


  get params() {
    return new URL(window.location.href).searchParams
  }
}
