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
				offset: 5,
			},
			dataType: "json",
			success: function(result){
				console.log('showing the result below');
				console.log(result);
			},
			error: function(results){
				console.log(results)
			},
	});
	};
	
	filter();

});
