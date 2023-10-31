import mapboxgl from "mapbox-gl"

const MapTrace = {
    initMap() {
        mapboxgl.accessToken = "pk.eyJ1IjoidmlraWhhcnJvZCIsImEiOiJjbG9lcnd2YzcwZTd4MmpvM25hOGJ4eDI5In0.u-6tFAKTJuvIblVID8_8RA";

        const mapConfig = {
            container: "map",
            style: "mapbox://styles/mapbox/streets-v12",
            center: [-1, 45.96985276821686],
            zoom: 11,
        };

        const map = new mapboxgl.Map(mapConfig);

        return map;
    },
    mounted() {
        this.initMap();
    },
};

export { MapTrace };
