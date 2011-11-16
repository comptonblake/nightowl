$(document).ready(function(){
	
		$('#btnlogin').live('click',function(e){
			var that = $(this);
			login = $('#loginForm');
			
			if(!login.is(":animated")){
				$(login).slideToggle('swing', function(){
					if( $(that).hasClass('active') )
					{
						$(that).removeClass('active');
					}else{
						$(that).addClass('active');
					}
				});
			};
			return false;
		});
		
		
		$('#btnsignup').live('click',function(){
			
			var that = $(this);
			var signupform = $('#signup');
			if(!signupform.is(':animated')){
				$(signupform).slideToggle('swing',function(){});
			};
			
			return false;
		});
});