$(document).ready(function(){
	$.ajaxSetup({
		url: "http://localhost:9999/nightowl/Advanced/index.cfm"
	})

	var filter = function(){
		$.ajax({
	//Online URL is 
			type: "GET",
			crossDomain: true,
			data: {
				event: 'api.index',		//Default Event Needed
			},
			dataType: "json",
			success: function(result){
				console.log(result);
			},
			error: function(results){
				console.log(results)
			},
	});
	};

});
