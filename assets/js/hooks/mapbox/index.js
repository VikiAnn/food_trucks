import mapboxgl from "mapbox-gl"

const MapBoxHook = {
    initMap() {
        mapboxgl.accessToken = "pk.eyJ1IjoidmlraWhhcnJvZCIsImEiOiJjbG9lcnd2YzcwZTd4MmpvM25hOGJ4eDI5In0.u-6tFAKTJuvIblVID8_8RA";

        const center_of_sf = [-122.431297, 37.773972]
        const mapConfig = {
            container: "map",
            style: "mapbox://styles/mapbox/streets-v12",
            center: center_of_sf,
            zoom: 11,
        };

        this.map = new mapboxgl.Map(mapConfig);

        return map;
    },
    mounted() {
        this.handleEvent("vendorMarkers", e => {
            e.markers.map(marker => {
                const coords = [marker.longitude, marker.latitude];
                new mapboxgl.Marker().setLngLat(coords).addTo(this.map);
            })
        })
        this.initMap();
        this.pushEvent("after_render", {});
    },
};

export { MapBoxHook };
