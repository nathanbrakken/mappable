var MapStores = new function(){
	var map;

	// Initial zoom for the map
	var mapCenter = new google.maps.LatLng(40.74394060479145, -74.03214454650879);

	// Set the styles of the map
	var styles = [
	{
	  stylers: [
	      { hue: "#00d4ff" },
		  { saturation: -100 },
		  { lightness: -30 },
		  { gamma: 0 }
	  ]
	},{
	  featureType: "road",
	  elementType: "geometry",
	  stylers: [
	    { lightness: 100 },
	    { visibility: "simplified" }
	  ]
	},{
	  featureType: "road",
	  elementType: "labels",
	  stylers: [
	    { visibility: "off" }
	  ]
	}
	];

	// Set all the variables for infobox
	function createInfoBox(content) {
		return new InfoBox({
		    content: "<div class='infobox'>" + content + "</div>",
		    disableAutoPan: false,
		    //x y
		    pixelOffset: new google.maps.Size(10, -35),
		    zIndex: null,
		    
		    closeBoxMargin: "0px",
		    closeBoxURL: "",
		    infoBoxClearance: new google.maps.Size(1, 1)
		})
	};

	// Init
	this.initStoreLocationMapper = function() {
		//get some map options
		var mapOptions = {
			zoom: 12,
			center: mapCenter,
			mapTypeId: google.maps.MapTypeId.ROADMAP, 
			styles: styles
		}

		map = new google.maps.Map(document.getElementById("map-canvas"), mapOptions);
		
		$.get('/stores.json', function(stores){
			placeMapMarkers(stores);
		});
		var placeMapMarkers = function(stores) {
			$.each(stores, function(i, store) {

				xyCoords = new google.maps.LatLng(store.x_coord, store.y_coord)

				var marker = new google.maps.Marker({
					position: xyCoords,
					map: map,
					draggable: true
					// Set custom icon with the following
					// icon: '/assets/marker_images/' + store.status_id + '.png'
				});

				infobox = createInfoBox(store.name)
				info = new google.maps.InfoWindow(infobox);
				info.open(map, marker);

				google.maps.event.addListener(
			    marker,
			    'dragend',
			    function(event) {
			        $('#confirm_change_coords').modal('show');
			        $('#store_name').html(store.name);
			        $('#x_coords').html(this.position.lat());
			        $('#y_coords').html(this.position.lng());
			        newStoreAttribs = {}
			        newStoreAttribs.x_coord = this.position.lat();
			        newStoreAttribs.y_coord = this.position.lng();
			        newStoreAttribs.id = store.id;
			        $('#update_coords').data(newStoreAttribs)
			    });
			});
		}

	}

	$(function(){
		//for saving the new coordinates
		$('#update_coords').on('click', function(){
		storeObj = $(this).data();
		storeId = storeObj.id;
		delete storeObj.id;
			$.ajax({
			    url: '/stores/' + storeId + '.json',
			    type: 'PUT',
			    data: {'store': $(this).data()},
			    success: function(result) {
			    	$('#confirm_change_coords').modal('hide');
			    }
			});
		});
		//just target the map_stores page
		var  map_stores_page = $('#map_stores').val();

		if (map_stores_page != null) {
			MapStores.initStoreLocationMapper();
		}
	});
}
