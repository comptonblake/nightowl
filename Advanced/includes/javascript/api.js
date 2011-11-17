$(document).ready(function(){
	$.ajaxSetup({
		url: "http://localhost:9999/nightowl/Advanced/index.cfm"
	})

	var filter = function(){
		$.ajax({
	//Online URL is 
			type: "GET",
			data: {
				event: 'api.index',		//Default Event Needed
				offset: 0,
				limit: 5
			},
			dataType: "json",
			success: function(result){
				console.log('showing the result below');
				console.log(result);
				filterresults(result);
			},
			error: function(results){
				console.log(results)
			},
	});
	};
	
	filter();
	
	
	var filterresults = function(result){
	
		$('#eventdriver').html('');	
		
		

		$.each(result, function(i,events){
		
			$('#eventdriver').append('<div class="event">' + '<div class="left">' + '<p class="eventimg"><img src="includes/images/users/' + events.filename + '"/></p>' + '</div>' + '<div class="right">' + '<h3>' + events.title + '</a></h3>' + '<p class="descript">' + events.description + '</p>' + '<p class="detailed">' + events.date + '</p>' + '<p class="detailed">' + events.time + '</p>' + '<p class="detailed">' + events.location + '</p>' + '</div>');
			
			
				
		
		});


		
	
	}

});
