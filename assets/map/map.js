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
