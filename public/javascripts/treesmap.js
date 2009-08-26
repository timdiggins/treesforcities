
function initialize() { 
  if (GBrowserIsCompatible() && typeof trees != 'undefined') {
    var map = new GMap2(document.getElementById("map"));
    map.setCenter(new GLatLng(51.509964, -0.134679), 13); //piccadilly circus
    map.addControl(new GLargeMapControl());

    // Clicking the marker will hide it
    function createMarker(latlng, tree) {
      var icon =  new GIcon(G_DEFAULT_ICON);
      var empty_lot = false;
			if (empty_lot) {
        icon.image = '/images/icons/lot.png';
      } else {
        icon.image = '/images/icons/tree.png';
      }
      var marker = new GMarker(latlng,icon);
      var html="<strong><a href='/trees/"+tree.id+"'>"
      if (empty_lot) {
        html += "Empty lot #"+tree.id+"</a></strong><br />";
      } else {
        html +="Tree #"+tree.tree_no+"</a></strong><br />";
      }
			html += tree.nearest_address + " "+tree.postcode;
      GEvent.addListener(marker,"click", function() {
        map.openInfoWindowHtml(latlng, html);
      });
      return marker;
    }

    var bounds = new GLatLngBounds();
    for (var i = 0; i < trees.length; i++) {
      var tree = trees[i].tree;
      var latlng=new GLatLng(tree.lat,tree.lng);
      bounds.extend(latlng);
      map.addOverlay(createMarker(latlng, tree));
      console.log('tree:'+tree.lat+' lat: ' + latlng.lat()+' bounds center: '+ bounds.getCenter());
    }
    map.setCenter(bounds.getCenter(), map.getBoundsZoomLevel(bounds));
  }
}  
