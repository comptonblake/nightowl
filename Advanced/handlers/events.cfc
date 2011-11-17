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
			}else{
				sessions.setVar('pagination', 0);
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
		sessions.setVar('pagination', 0);
			
		if(validate === true){
			var saveevent = eventsgateway.createevents(rc, sessions.getStorage());
			if(saveevent === true){
				rc.events = getevents;
				setNextEvent("events");
			}else{
				//show errors about it not saving
				rc.events = getevents;
				errors = structnew();
				errors.nothing = saveevent;
				rc.createerrors = errors;
				event.setView("events/content");
			}
		}else{
			rc.events = getevents;
			rc.createerrors = validate;
			event.setView("events/content");
			//display errors here
		}
	</cfscript>
</cffunction>


<cffunction name="userposts" returnType="void" output="false" hint="Get only user created events">
	<cfargument name="event">
	<cfargument name="rc">
	<cfargument name="prc">
	<cfscript>
		sessions.setVar('pagination', 0);
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
		sessions.setVar('pagination', 0);
		var inviteuser = eventsgateway.inviteuser(rc,sessions.getStorage());
		var getevents = eventsgateway.getevents();
				
		rc.events = getevents;
		setNextEvent("events");
	</cfscript>	
</cffunction>

<cffunction name="useruninvited" returnType="void" output="false" hint="The user doesn't want to go anymore.">
	<cfargument name="event">
	<cfargument name="rc">
	<cfargument name="prc">
<cfscript>
		sessions.setVar('pagination', 0);
		var uninviteuser = eventsgateway.uninviteuser(rc,sessions.getStorage());
		setNextEvent("events");
</cfscript>	
</cffunction>
<cffunction name="geteventby" returnType="void" output="false" hint="Get the post details by id">
		<cfargument name="event">
		<cfargument name="rc">
		<cfargument name="prc">
		<cfscript>
			sessions.setVar('pagination', 0);
			var getevent = eventsgateway.geteventsbyid(rc);
			
			if(IsStruct(getevent)){
				rc.events = #getevent#;
			}else{
				event.setView("404");
			}
			
			var getcomments = eventsgateway.getcommentsbyevent(rc);
			
			if(arrayLen(getcomments) gt 1){
				rc.comments = #getcomments#;
			}else{
				//throw some errors here
			}
			
			if(IsStruct(getevent)){
				event.setView("events/details");
			}else{
				event.setView("404");
			}

			
		</cfscript>
</cffunction>


<cffunction name="comment" returnType="void" output="false" hint="submit the comment that the user wants passed into the event">
		<cfargument name="event">
		<cfargument name="rc">
		<cfargument name="prc">
		<cfscript>
			sessions.setVar('pagination', 0);
			var comment = eventsgateway.sendcomment(rc,sessions.getStorage());
			
			var getevent = eventsgateway.geteventsbyid(rc);
			
			if(structCount(getevent) gt 1){
				rc.events = #getevent#;
				var getcomments = eventsgateway.getcommentsbyevent(rc);
			
				if(arrayLen(getcomments) gt 1){
					rc.comments = #getcomments#;
				}else{
					
				}
			}else{
				//throw some errors here
			}
			
			
			
			event.setView("events/details");
				
		</cfscript>
</cffunction>

<cffunction name="invitedevents" returnType="void" output="false" hint="submit the comment that the user wants passed into the event">
		<cfargument name="event">
		<cfargument name="rc">
		<cfargument name="prc">
		<cfscript>
		sessions.setVar('pagination', 0);
		var getinvitedevents = eventsgateway.invitedevents(sessions.getStorage());
		</cfscript>
</cffunction>

<cffunction name="loadmore" returnType="void" output="false" hint="submit the comment that the user wants passed into the event">
		<cfargument name="event">
		<cfargument name="rc">
		<cfargument name="prc">
		<cfscript>
		var loadmore = eventsgateway.loadmoreposts(sessions.getStorage());
		var increase = sessions.getStorage();
		var update = increase.pagination += 10;
		sessions.setVar('pagination',update);
		
		rc.events = loadmore;	
		event.setView("events/content");
		
		</cfscript>
</cffunction>















</cfcomponent>