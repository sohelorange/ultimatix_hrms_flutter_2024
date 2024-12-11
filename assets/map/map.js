// Create the OpenLayers map
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
          src: 'resources/locate.png', // URL to your icon image
        })
    })
});

// Add the vector layer to the map
map.addLayer(vectorLayer);


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

/*var lat = 23.011767; // Example: San Francisco latitude
var lon = 72.502564;*/ // Example: San Francisco longitude

// Define the projection (EPSG:4326 for latitude/longitude)
var projection = 'EPSG:4326';
/*geoFencing();*/

function geoFencing(geoFenceLon, geoFenceLat, userLon, userLat){
// Define the geofence (Circle) with a 500-meter radius
    var radius = 500; // 500 meters
    var center = ol.proj.fromLonLat([geoFenceLon, geoFenceLat]); //add this lat & lon as parameter to geoFencing method

    var geofence = new ol.Feature({
      geometry: new ol.geom.Circle(center, radius),
    });

    // Style for the geofence
    var geofenceStyle = new ol.style.Style({
      stroke: new ol.style.Stroke({
        color: 'rgba(255, 0, 0, 1)', // Red border
        width: 3
      }),
      fill: new ol.style.Fill({
        color: 'rgba(255, 0, 0, 0.2)' // Light red fill
      })
    });

    // Apply the style to the geofence
    geofence.setStyle(geofenceStyle);

    // Add the geofence to the map
    var vectorSource = new ol.source.Vector({
      features: [geofence]
    });

    var vectorLayer = new ol.layer.Vector({
      source: vectorSource
    });

    map.addLayer(vectorLayer);


    // Convert user lat/lon to map projection (EPSG:3857)
      var userPosition = ol.proj.fromLonLat([userLon, userLat]);

      // Get the circle geometry from the geofence feature
      var circleGeometry = geofence.getGeometry();

      // Check if the user's position is inside the circle
      var isInsideGeofence = circleGeometry.intersectsCoordinate(userPosition);

      if (!isInsideGeofence) {
        console.log("User's current position is OUTSIDE the geofence.");
        console.log("Current Latitude: " + latitude + ", Longitude: " + longitude);
      } else {
        console.log("User is INSIDE the geofence.");
      }
}

/*function checkUserInGeofence(latitude, longitude) {
  // Convert user lat/lon to map projection (EPSG:3857)
  var userPosition = ol.proj.fromLonLat([longitude, latitude]);

  // Get the circle geometry from the geofence feature
  var circleGeometry = geofence.getGeometry();

  // Check if the user's position is inside the circle
  var isInsideGeofence = circleGeometry.intersectsCoordinate(userPosition);

  if (!isInsideGeofence) {
    console.log("User's current position is OUTSIDE the geofence.");
    console.log("Current Latitude: " + latitude + ", Longitude: " + longitude);
  } else {
    console.log("User is INSIDE the geofence.");
  }
}*/

/*var userLatitude = 37.7750;  // Example user latitude (close to the geofence center)
var userLongitude = -122.4195;*/  // Example user longitude (close to the geofence center)

// Check if the user is inside the geofence using the function
/*checkUserInGeofence(userLatitude, userLongitude);*/

// Function to pan the map in a specific direction
function panMap(direction) {
  const view = map.getView();
  const currentCenter = view.getCenter();
  const panDistance = 100000; // Distance to pan in pixels

  let newCenter;
  switch (direction) {
    case 'left':
      newCenter = [currentCenter[0] - panDistance, currentCenter[1]];
      break;
    case 'right':
      newCenter = [currentCenter[0] + panDistance, currentCenter[1]];
      break;
    case 'up':
      newCenter = [currentCenter[0], currentCenter[1] - panDistance];
      break;
    case 'down':
      newCenter = [currentCenter[0], currentCenter[1] + panDistance];
      break;
  }

  // Update the map center to the new position
  view.setCenter(newCenter);
}

// Create custom pan controls (left, right, up, down)
const controlContainer = document.createElement('div');
controlContainer.className = 'custom-pan-controls';

// Create buttons for left, right, up, and down
const leftButton = document.createElement('button');
leftButton.textContent = '←';
leftButton.title = 'Pan Left';
leftButton.className = 'pan-button';
leftButton.onclick = () => panMap('left');

const rightButton = document.createElement('button');
rightButton.textContent = '→';
rightButton.title = 'Pan Right';
rightButton.className = 'pan-button';
rightButton.onclick = () => panMap('right');

const upButton = document.createElement('button');
upButton.textContent = '↑';
upButton.title = 'Pan Up';
upButton.className = 'pan-button';
upButton.onclick = () => panMap('up');

const downButton = document.createElement('button');
downButton.textContent = '↓';
downButton.title = 'Pan Down';
downButton.className = 'pan-button';
downButton.onclick = () => panMap('down');

// Append buttons to the control container
controlContainer.appendChild(leftButton);
controlContainer.appendChild(upButton);
controlContainer.appendChild(downButton);
controlContainer.appendChild(rightButton);

// Add the custom controls to the map's DOM
document.getElementById('map').appendChild(controlContainer);

// Styling the buttons (optional)
const style = document.createElement('style');
style.innerHTML = `
  .custom-pan-controls {
    position: absolute;
    top: 10px;
    left: 10px;
    display: flex;
    flex-direction: column;
    gap: 5px;
  }
  .pan-button {
    padding: 10px;
    font-size: 16px;
    cursor: pointer;
  }
`;
document.head.appendChild(style);
