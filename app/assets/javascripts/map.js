ymaps.ready(init);
var myMap;

function init(){
  mapDiv = document.getElementById('map');

  if (mapDiv != null) {
    address = mapDiv.getAttribute('data-address');

    myMap = new ymaps.Map("map", {
      center: [55.76, 37.64],
      zoom: 10
    });

    myGeocoder = ymaps.geocode(address);

    myGeocoder.then(
      function (res) {
        coordinates = res.geoObjects.get(0).geometry.getCoordinates();

        myMap.geoObjects.add(
          new ymaps.Placemark(
            coordinates,
            {iconContent: address},
            {preset: 'islands#blueStretchyIcon'}
          )
        );

        myMap.setCenter(coordinates);
        myMap.setZoom(15);
      }, function (err) {
        alert('Îøèáêà ïðè îïðåäåëåíèè ìåñòîïîëîæåíèÿ');
      }
    );
  }
}