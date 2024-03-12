import { Controller } from "@hotwired/stimulus"
import mapboxgl from 'mapbox-gl'

export default class extends Controller {
  static values = {
    apiKey: String,
    markers: Array
  }

  connect() {
    mapboxgl.accessToken = this.apiKeyValue

    this.map = new mapboxgl.Map({
      container: this.element,
      style: "mapbox://styles/mapbox/streets-v10"
    })




    this.#addMarkersToMap();
    this.#fitMapToMarkers();
  }

  #addMarkersToMap() {
    if(this.markersValue.length !== 0){
      this.markersValue.forEach((marker) => {

        const customMarker = document.createElement("div");
        customMarker.innerHTML = marker.marker_html;

        new mapboxgl.Marker(customMarker)
          .setLngLat([ marker.lng, marker.lat ])
          .addTo(this.map)
      })
    }
  }
  #fitMapToMarkers() {
    const bounds = new mapboxgl.LngLatBounds()
    if(this.markersValue.length !== 0){
      this.markersValue.forEach(marker => bounds.extend([ marker.lng, marker.lat ]))
      this.map.fitBounds(bounds, { padding: 100, maxZoom: 14, duration: 0 })
    } else {
      let array_bordeaux = [{lng:-0.6464625, lat:44.87498},{lng:-0.4666680, lat:44.75823}]
      array_bordeaux.forEach(marker => bounds.extend([ marker.lng, marker.lat ]))
      this.map.fitBounds(bounds, { padding: 100, maxZoom: 14, duration: 0 })
    }
  }
}
