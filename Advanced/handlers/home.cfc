<cfcomponent extends="coldbox.system.eventhandler" autowire="true">
	
	<cfproperty name="users" inject="model:users">
	<cfproperty name="ORMService" inject="coldbox:plugin:ORMService">
	<cfproperty name="usergateway" inject="model:UserGateway">
	<cfproperty name="sessions" inject="coldbox:plugin:SessionStorage">

	<cfscript>
		this.event_cache_suffix = "";
		this.prehandler_only 	= "";
		this.prehandler_except 	= "";
		this.posthandler_only 	= "";
		this.posthandler_except = "";
		this.aroundHandler_only = "";
		this.aroundHandler_except = "";		
		/* HTTP Methods Allowed for actions. */
		/* Ex: this.allowedMethods = {delete='POST,DELETE',index='GET'} */
		this.allowedMethods = structnew();
	</cfscript>
	


<!------------------------------------------- PUBLIC EVENTS ------------------------------------------>

	<!--- Default Action --->
	<cffunction name="index" returntype="void" output="false" hint="My main event">
		<cfargument name="event">
		<cfargument name="rc">
		<cfargument name="prc">
<!--- 		<cfajaxproxy cfc="model.eventsgateway" jsclassname="events"> --->
		<cfset event.setView("general/content")>
	</cffunction>

	<cffunction name="signup" returnType="void" output="false" hint="My Sign Up Event">
		<cfargument name="event">
		<cfargument name="rc">
		<cfargument name="prc">

		<cfscript>
			var validateInput = usergateway.validate(rc);
			
			
			if(validateInput === true){
				var user = populateModel("users");
				var createuser = usergateway.createtheuser(rc);
					
				if(isStruct(createuser)){
					sessions.clearAll();
					//sessions.startStorage();
					var setusername = sessions.setvar("username", createuser.getUsername());
					var setuserid = sessions.setvar("id", createuser.getUser_id());
					var setemail = sessions.setvar("email",createuser.getEmail());
					var setfirstname = sessions.setvar("firstname", createuser.getFirstname());
					var setlastname = sessions.setvar("lastname", createuser.getLastname()); 
					var setfilename = sessions.setvar("filename", createuser.getFilename()); 
					setNextEvent("events");
					
				}else{
					errors = structnew();
					errors.nothing = createuser;
					rc.signuperrors = errors;
					event.setView("general/content");
				}
			
			}else{
				rc.signuperrors = validateInput;
				event.setView("general/content");			
			}
			
			event.setView("general/content");
			
			
		</cfscript>
	</cffunction>
		
	<cffunction name="login" returnType="void" output="false" hint="My login event">
		<cfargument name="event">
		<cfargument name="rc">
		<cfargument name="prc">
		
		<cfscript>
			var checkvalid = usergateway.validatelogin(rc);
			
			if(checkvalid === true){
				var getuserlogin = usergateway.getlogininfo(rc);
			
				if(getuserlogin === false){
					errors = structnew();
					errors.nothing = "Please enter your correct password";
					rc.loginerrors = errors;
					event.setView("general/content");
				}else{
					sessions.removeStorage();
					//sessions.startStorage();
					var setusername = sessions.setvar("username", getuserlogin[1].getUsername());
					var setuserid = sessions.setvar("id", getuserlogin[1].getUser_id());
					var setemail = sessions.setvar("email",getuserlogin[1].getEmail());
					var setfirstname = sessions.setvar("firstname", getuserlogin[1].getFirstname());
					var setlastname = sessions.setvar("lastname", getuserlogin[1].getLastname()); 
					var setfilename = sessions.setvar("filename", getuserlogin[1].getFilename()); 
					var setpagination = sessions.setvar("pagination", 0);
					setNextEvent("events");
				}
			
			}else{
				rc.loginerrors = checkvalid;
				event.setView("general/content");
				//write for errors			
			}
		</cfscript>
	</cffunction>
	
	
	
	<cffunction name="logout" returnType="void" output="false" hint="My logout event">
		<cfargument name="event">
		<cfargument name="rc">
		<cfargument name="prc">
		
		<cfscript>
			sessions.clearAll();
			setNextEvent("home");
		</cfscript>
	</cffunction>
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	

</cfcomponent>