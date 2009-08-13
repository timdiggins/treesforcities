
function initialize() { 
  if (GBrowserIsCompatible() && typeof lots != 'undefined') {
    var map = new GMap2(document.getElementById("map"));
    map.setCenter(new GLatLng(51.509964, -0.134679), 13); //piccadilly circus
    map.addControl(new GLargeMapControl());

    // Clicking the marker will hide it
    function createMarker(latlng, lot) {
      var icon =  new GIcon(G_DEFAULT_ICON);
      if (lot.tree == null) {
      icon.image = '/images/icons/lot.png';
    } else {
      icon.image = '/images/icons/tree.png';
    }
      var marker = new GMarker(latlng,icon);
      var html="<strong><a href='/lots/"+lot.id+"'>"
      if (lot.tree == null) {
        html += "Empty lot #"+lot.id+"</a></strong><br />";
      } else {
        html +="Tree #"+lot.tree.tree_no+"</a></strong><br />";
      }
			html += lot.nearest_address + " "+lot.postcode;
      GEvent.addListener(marker,"click", function() {
        map.openInfoWindowHtml(latlng, html);
      });
      return marker;
    }

    var bounds = new GLatLngBounds();
    for (var i = 0; i < lots.length; i++) {
      var lot = lots[i].lot;
      var latlng=new GLatLng(lot.lat,lot.lng);
      bounds.extend(latlng);
      map.addOverlay(createMarker(latlng, lot));
      console.log('lot:'+lot.lat+' lat: ' + latlng.lat()+' bounds center: '+ bounds.getCenter());
    }
    map.setCenter(bounds.getCenter(), map.getBoundsZoomLevel(bounds));
  }
}  
