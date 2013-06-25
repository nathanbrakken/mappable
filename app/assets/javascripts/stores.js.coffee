$(document).ready ->
	$('form#new_store, form#edit_store').submit (e) ->
		e.preventDefault()
		address = $('#store_address').val()
		y_coord = $('#store_y_coord').val()
		if(address == '')
			alert 'you need to fill in an address'
			return
		if(y_coord == '')
			getCoordsFromAddress address
		else	
			$(this).unbind()
			$('form#new_store').submit()

	update_page = $('#update_coords').val()

	if update_page?		
		$('#update_coords').on 'click', ->
			deal_with_stores()
		deal_with_stores = ->
			$.each stores, (i, val) -> 
				$('.updates').append(val.name + ': ' + val.x_coord + ', ' + val.y_coord + '<br />')

	getCoordsFromAddress = (address) ->
		geocoder = new google.maps.Geocoder();
		coords = geocoder.geocode { 'address': address}, (results, status) -> 
				$('#store_x_coord').val(results[0].geometry.location.jb)
				$('#store_y_coord').val(results[0].geometry.location.kb)
				console.log(results[0].geometry.location)
				$('form#new_store').submit()



