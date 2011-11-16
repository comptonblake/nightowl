<cfcomponent extends="coldbox.system.eventhandler" autowire="true">
		<cfproperty name="sessions" inject="coldbox:plugin:SessionStorage"/>
		<cfproperty name="ORMService" inject="coldbox:plugin:ORMService">
		<cfproperty name="eventsgateway" inject="model:EventsGateway"/>

<cffunction name="index" returntype="void" output="false" hint="My main event">
		<cfargument name="event">
		<cfargument name="rc">
		<cfargument name="prc">
		<cfscript>
			
			var checklogin = sessions.getStorage();
			
			if(structcount(checklogin) lt 2){
				setNextEvent("home");
			}
			
			var getevents = eventsgateway.getevents();
			rc.events = getevents;	
			event.setView("events/content");
		</cfscript>
</cffunction>

<cffunction name="createevent" returnType="void" output="false" hint="My creation of events">
	<cfargument name="event">
	<cfargument name="rc">
	<cfargument name="prc">
	<cfscript>
		var validate = eventsgateway.validateevent(rc);
		var getevents = eventsgateway.getevents();
			
		if(validate === true){
			var saveevent = eventsgateway.createevents(rc, sessions.getStorage());
			if(saveevent === true){
				rc.events = getevents;
				event.setView("events/content");
			}else{
				//show errors about it not saving
				writedump("Show errors here");
				abort;
			}
		}else{
			//display errors here
		}
	</cfscript>
</cffunction>


<cffunction name="userposts" returnType="void" output="false" hint="Get only user created events">
	<cfargument name="event">
	<cfargument name="rc">
	<cfargument name="prc">
	<cfscript>
		
		var getuserevents = eventsgateway.getuserevents(rc, sessions.getStorage());
		
		if(arrayLen(getuserevents) gt 1){
			rc.events = getuserevents;
			event.setView("events/content");
		}else{
			writedump("user has no events");
			abort;
		}
			
	</cfscript>
</cffunction>


<cffunction name="userinvite" returnType="void" output="false" hint="Post user invite">
	<cfargument name="event">
	<cfargument name="rc">
	<cfargument name="prc">
	<cfscript>
		var inviteuser = eventsgateway.inviteuser(rc,sessions.getStorage());
		var getevents = eventsgateway.getevents();
				
		rc.events = getevents;
		event.setView("events/content");
	</cfscript>	
</cffunction>

<cffunction name="useruninvited" returnType="void" output="false" hint="The user doesn't want to go anymore.">
	<cfargument name="event">
	<cfargument name="rc">
	<cfargument name="prc">
<cfscript>
		var uninviteuser = eventsgateway.uninviteuser(rc,sessions.getStorage());
</cfscript>	
</cffunction>

<cffunction name="getnextevents" returnType="void" output="false" hint="Get the next ten events">
	<cfargument name="event">
	<cfargument name="rc">
	<cfargument name="prc">
	<cfscript>
		var gotonext = eventsgateway.getnextevents(rc,sessions.getStorage());
		var increase = sessions.getVar("pagination");
		increase += 10;
		var setpagination = sessions.setvar("pagination", increase);
		
		rc.events = gotonext;
		event.setView("events/content");
	</cfscript>
</cffunction>
<cffunction name="geteventby" returnType="void" output="false" hint="Get the post details by id">
		<cfargument name="event">
		<cfargument name="rc">
		<cfargument name="prc">
		<cfscript>
			var getevent = eventsgateway.geteventsbyid(rc);
			
			if(structCount(getevent) gt 1){
				rc.events = #getevent#;
			}else{
				//throw some errors here
			}
			
			var getcomments = eventsgateway.getcommentsbyevent(rc);
			
			if(arrayLen(getcomments) gt 1){
				rc.comments = #getcomments#;
			}else{
				//throw some errors here
			}
			
			event.setView("events/details");
		</cfscript>
</cffunction>


<cffunction name="comment" returnType="void" output="false" hint="submit the comment that the user wants passed into the event">
		<cfargument name="event">
		<cfargument name="rc">
		<cfargument name="prc">
		<cfscript>
			var comment = eventsgateway.sendcomment(rc,sessions.getStorage());
			var getevent = eventsgateway.geteventsbyid(rc);
			
			if(structCount(getevent) gt 1){
				rc.events = #getevent#;
			}else{
				//throw some errors here
			}
			
			var getcomments = eventsgateway.getcommentsbyevent(rc);
			
			if(IsStruct(getcomments)){
				rc.comments = #getcomments#;
			}else{
				//throw some errors here
			}

			event.setView("events/details");	
		</cfscript>
</cffunction>



















</cfcomponent>