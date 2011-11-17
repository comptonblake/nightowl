<cfscript>
component name="UserGateway" cache="true" cacheTimeout="0"{

	instance = structnew();

	function validate(form){
		var errors = structNew();
		var checkinputs = application.cbcontroller.getPlugin("Validator");
		
		var firstname = checkinputs.checkMinLen(form.firstname,1);
			firstname ? "" : errors.firstname = "Please enter your first name";
		var lastname = checkinputs.checkMinLen(form.lastname,1);
			lastname ? "" : errors.lastname = "Please enter your last name";
		var username = checkinputs.checkMinLen(form.username,8);
			username ? "" : errors.username = "Please enter a username with at least 8 characters";
		var password = checkinputs.checkMinLen(form.password, 7);
			password ? "" : errors.password = "Please enter a username with at least 8 characters";
		var email = checkinputs.checkEmail(form.email);
			email ? "" : errors.email = "Please enter a correct email address";
		
		if(structcount(errors) LT 1){
			//createtheuser(form);
			writedump("submit form here");
			return true;
		}else{
			return errors;
		}	
	};
	
	function createtheuser(rc){
	
		//grabs the plugin for the ORM service to be written and executed
		var user = application.cbcontroller.getPlugin("ORMService");
		
		//checks to see if the user already exists and returns an errors if so.
		var userfound = user.findAll("from users as u where u.email=:email", { email="#rc.email#"} );

		//the array of users found is not empty
		if(!ArrayIsEmpty(userfound)){
			
			//creating a struct of errors to be passed to the controller
			return "The user with email #rc.email# already exists";
			
		}else{
			
			//creates the user that needs to be saved and where
			var setuser = user.new("users", rc);
			
			strLowerCaseAlpha = "abcdefghijklmnopqrstuvwxyz";
			strUpperCaseAlpha = UCase( strLowerCaseAlpha );
			strNumbers = "0123456789";
			strAllValidChars = (strLowerCaseAlpha & strUpperCaseAlpha & strNumbers );
			
			salt = '';
			for (i=1;i LTE 8;i=i+1) {
				variables.salt = variables.salt &  Mid(strAllValidChars, RandRange( 1, Len( strAllValidChars )), 1 );
			}
		
			//Hashing Password
			password = hash(setuser.getPassword() & variables.salt);
			setuser.setPassword(password);
			setuser.setSalt(salt);
			//give the user a default filename
			var filename = "default.png";
						
			setuser.setFilename(filename);
			//saves the user using the ORMservice
			var saved = user.save(setuser);
			ORMflush();
			
			//the new users information so that we can create the session
			return setuser;
		}
	
		//returns this if nothing worked :(
		return false;		
	}
	
	
	function validatelogin(rc){
		var errors = structnew();
		var checklogin = application.cbcontroller.getPlugin("Validator");
		
		var email = checklogin.checkMinLen(rc.email,1);
			email ? "" : errors.email = "Please enter your email address";
		var password = checklogin.checkMinLen(rc.password,1);
			password ? "" : errors.password = "Please enter your password";
				
		if(structcount(errors) LT 1){
			//createtheuser(form);
			writedump("submit form here");
			return true;
		}else{
			return errors;
		}	

	
	}
	
	
	
	
	function getlogininfo(rc){
		//grabs the plugin for the ORM service to be written and executed
		var user = application.cbcontroller.getPlugin("ORMService");
		
		//checks to see if the user exists and returns an errors if not.
		var userfound = user.findAll("from users as u where u.email=:email", { email="#rc.email#"} );
		
		if(ArrayIsEmpty(userfound)){
			//creating a struct of errors to be passed to the controller
			var errors = structNew();
			errors.email = "The user with email #rc.email# doesn't exists";
			return false;
		
		}else{
			
			var password = userfound[1].getPassword();
			var entered = rc.password;
			var salt = userfound[1].getSalt();
			
			//the answer
			var answer = hash(entered & salt);
			
			if(password == answer){
				
				return userfound;
			}else{
			
				return false;
			}
		
		}
	}
	
	function getUsername( required userId )
	{
		var user = application.cbcontroller.getPlugin("ORMService");
		try{
			//writeDump( user.getPropertyNames('users') );
			//writeDump(user.findWhere(entityName='users', {user_id=arguments.userId}));
			
			var thing = user.get('users', arguments.userId );
		}catch(any e){
			writeDump(e);
			abort;
		}
	//	writeDump(thing.getUserName());
	//	abort;	
		return thing.getUserName();
	}
	
	
	
	function getFilename(userid){
		var user = application.cbcontroller.getPlugin("ORMService");
	
		try{
			var getevent = user.findIt("from users as e where e.user_id=:id", {id=arguments.userid});
			
			return getevent.getFilename();
			
		}catch(any e){
			writedump(e);
			abort;
		
		}
	
	
	}
	
	
	
}
</cfscript>