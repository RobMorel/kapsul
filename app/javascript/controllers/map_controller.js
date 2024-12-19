import { Controller } from "@hotwired/stimulus"
import mapboxgl from 'mapbox-gl'

// Connects to data-controller="map"
export default class extends Controller {

  static values = {
    apiKey: String,
    markers: Array,
    imagePath: String
  }

  static targets = ['map']

  userLocation = { latitude: 48.8566, longitude: 2.3522 };

  connect() {
    console.log('Map controller connected')
    this.initMapbox();
    this.#addMarkersToMap();
    this.#fitMapToMarkers();
    this.map.addControl(new MapboxGeocoder({ accessToken: mapboxgl.accessToken,
      mapboxgl: mapboxgl }))
  }

  initMapbox() {
    mapboxgl.accessToken = this.apiKeyValue
    this.map = new mapboxgl.Map({
      container: this.mapTarget,
      style: 'mapbox://styles/rob738/cm4nai60l004d01qtaw80cp3z',
      center: [2.3522, 48.8566],
      zoom: 10
    });

    this.map.on("load", () => {
      const imagePath = this.imagePathValue;
      console.log("Image path value:", imagePath);
      this.map.loadImage(imagePath, (error, image) => {
        if (error) {
          console.error("Error loading custom map image:", error);
          return;
        }
        this.map.addImage("custom-geolocate-icon", image);
      });
    });

  }

  geolocate(event) {
  event.preventDefault();
  console.log("Geolocate button clicked");

  if (navigator.geolocation) {
    navigator.geolocation.getCurrentPosition(
      (position) => {
        console.log("bla bla User's current position:", position);
        const { latitude, longitude, heading } = position.coords;
        this.userLocation = { latitude, longitude };
        this.#addMarkersToMap();
        this.updateMapCenter([longitude, latitude], heading);
      },
      (error) => {
        console.error("Error getting current position:", error);
      },
      { enableHighAccuracy: true }
    );
  } else {
    console.error("Geolocation is not supported by this browser.");
  }
  }

     updateMapCenter([longitude, latitude], heading = 0) {
      this.addOrUpdateUserCursor([longitude, latitude], heading);

      this.addCircleToMap([longitude, latitude]);

      console.log(`FlyTo Center: Longitude: ${longitude}, Latitude: ${latitude}`);
      this.map.flyTo({ center: [longitude, latitude], zoom: 15, essential: true });
    }

    addOrUpdateUserCursor([longitude, latitude], heading) {
      const cursorId = "user-heading-cursor";

      if (this.map.getSource(cursorId)) {
        this.map.getSource(cursorId).setData({
          type: "Feature",
          geometry: { type: "Point", coordinates: [longitude, latitude] }
        });
        this.map.setLayoutProperty(cursorId, "icon-rotate", heading || 0);
      } else {
        this.map.addSource(cursorId, {
          type: "geojson",
          data: {
            type: "Feature",
            geometry: { type: "Point", coordinates: [longitude, latitude] }
          }
        });

        this.map.addLayer({
          id: cursorId,
          type: "symbol",
          source: cursorId,
          layout: {
            "icon-image": "custom-geolocate-icon",
            "icon-size": 0.05,
            "icon-rotate": heading || 0,
            "icon-allow-overlap": true
          }
        });
      }
    }


    addCircleToMap([longitude, latitude]) {
      const circleId = "user-location-circle";
      const radiusInMeters = 200; // 200 meters fixed

      const createGeoJSONCircle = (center, radius, points = 64) => {
        const coords = [];
        const earthRadius = 6378137; // Earth's radius in meters (WGS84 standard)

        for (let i = 0; i < points; i++) {
          const angle = (i * 360) / points; // Angle in degrees
          const offsetX = (radius / earthRadius) * Math.cos(angle * (Math.PI / 180)); // Longitude offset in radians
          const offsetY = (radius / earthRadius) * Math.sin(angle * (Math.PI / 180)); // Latitude offset in radians

          const adjustedX = center[0] + (offsetX * (180 / Math.PI)) / Math.cos(center[1] * (Math.PI / 180));
          const adjustedY = center[1] + (offsetY * (180 / Math.PI));

          coords.push([adjustedX, adjustedY]);
        }

        coords.push(coords[0]); // Close the circle
        return {
          type: "Feature",
          geometry: {
            type: "Polygon",
            coordinates: [coords]
          }
        };
      };


      const circleData = createGeoJSONCircle([longitude, latitude], radiusInMeters);

      if (this.map.getSource(circleId)) {
        this.map.getSource(circleId).setData(circleData);
      } else {
        this.map.addSource(circleId, { type: "geojson", data: circleData });

        this.map.addLayer({
          id: circleId,
          type: "fill",
          source: circleId,
          paint: {
            "fill-color": "#9c8034",
            "fill-opacity": 0.3,
            "fill-outline-color": "#9c8034"
          }
        });
      }
    }

    #addMarkersToMap() {
      console.log('adding markers to map')
      console.log("Markers Value:", this.markersValue);
      console.log("User Location:", this.userLocation);

      if (!this.userLocation) {
        console.error("User location is not available yet.");
        return; // Skip adding markers until userLocation is set
      }

      const userLngLat = new mapboxgl.LngLat(this.userLocation.longitude, this.userLocation.latitude);
      const radiusInMeters = 200;

      this.markersValue.forEach((marker) => {
        const markerLngLat = new mapboxgl.LngLat(marker.lng, marker.lat);

        const distance = userLngLat.distanceTo(markerLngLat);

        const isClickable = distance <= radiusInMeters || marker.is_owner;

        const popup = new mapboxgl.Popup().setHTML(marker.infoWindow);

        const customMarker = document.createElement("div");
        customMarker.innerHTML = marker.marker_html;

        const mrker = new mapboxgl.Marker(customMarker)
          .setLngLat(markerLngLat)
          .addTo(this.map);

        if ((marker.is_owner) && (this.params.get("lat") == marker.lat) && (this.params.get("lng") == marker.lng)) {
          mrker.setPopup(popup).togglePopup();
        } else if (isClickable) {
          mrker.setPopup(popup);
        } else {
          customMarker.style.pointerEvents = "none";
          customMarker.style.opacity = 0.5;
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
      }
    }

    get params() {
      return new URL(window.location.href).searchParams
    }

    disconnect() {
      if (this.geolocationWatcherId) {
        navigator.geolocation.clearWatch(this.geolocationWatcherId);
        console.log("Geolocation watcher cleared on disconnect:", this.geolocationWatcherId);
        this.geolocationWatcherId = null;
      }
    }

}
