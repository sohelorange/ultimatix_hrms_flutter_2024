
const map = new ol.Map({
  target: 'map',
  controls: ol.control.defaults({ attribution: false }),
  layers: [
    new ol.layer.Tile({
      source: new ol.source.OSM()
    })
  ],
  view: new ol.View({
    center: [0, 0],
    zoom: 0
  })
});

// Create a vector source for displaying locations
const vectorSource = new ol.source.Vector();
// Create a vector layer for displaying locations
const vectorLayer = new ol.layer.Vector({
    source: vectorSource,
    style: new ol.style.Style({
        image: new ol.style.Icon({
          src: 'resources/locate.png',// URL to your icon image
        })
    })
});
// Add the vector layer to the map
map.addLayer(vectorLayer);

// Function to display location with an icon
function displayLocation(longitude, latitude) {

  vectorSource.clear();
  // Create a feature with the location
  const feature = new ol.Feature({
      geometry: new ol.geom.Point(ol.proj.fromLonLat([longitude, latitude])),
  });

  // Add the feature to the vector source
  vectorSource.addFeature(feature);

  // Set center and zoom level
  map.getView().setCenter(ol.proj.fromLonLat([longitude, latitude]));
  map.getView().setZoom(14);
}

/*const locations = [
   [72.4997, 22.9960], // New York City
   [72.5108, 23.0120] // Los Angeles
];*/

/*const locations = [
     [72.502564, 23.011767], // New York City
     [72.495011, 22.987336] // Los Angeles
];*/



/*displayTrack(locations);*/

function displayTrack(locations) {
  const lineString = new ol.geom.LineString(locations.map(coord => ol.proj.fromLonLat(coord)));

  const feature = new ol.Feature({
    geometry: lineString
  });

  const vectorSource = new ol.source.Vector({
    features: [feature]
  });

  const vectorLayer = new ol.layer.Vector({
    source: vectorSource,
    style: new ol.style.Style({
      stroke: new ol.style.Stroke({
        color: 'blue',
        width: 5
      })
    })
  });

  map.addLayer(vectorLayer);

  /*After adding the track layer on map, it provides the distance.*/
  /*formatLength(lineString);*/
}

/*Now it's not used*/
function formatLength(line) {
  var length = Math.round(line.getLength() * 100) / 100;
  //const length = getLength(line); /*check before uncomment it.*/
  let output;
  if (length > 100) {
    output = Math.round((length / 1000) * 100) / 100 + ' ' + 'km';
  } else {
    output = Math.round(length * 100) / 100 + ' ' + 'm';
  }
 console.log('formatLength call: '+output);
    if(window.getDistanceByCord){
        getDistanceByCord.postMessage(output);
    }
};

/*Now it's not used*/
async function getAddress(longitude, latitude) {
 console.log('getAddress call: '+longitude+ ', '+latitude);
  const response = await fetch(`https://nominatim.openstreetmap.org/reverse?format=json&lon=${longitude}&lat=${latitude}`);
  const data = await response.json();
  console.log('Data Getting: '+response.json());

  console.log('Data Getting: '+data);
  if(window.getAddressByLatLon){
    getAddressByLatLon.postMessage(data.display_name);
  }
}

