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
			event.setView("events/details");
		</cfscript>
</cffunction>

<cffunction name="eventid" returnType="void" output="false" hint="Get the post details by id">
		<cfargument name="event">
		<cfargument name="rc">
		<cfargument name="prc">
		<cfscript>
			//var getevents = eventsgateway.geteventsbyid();
			event.setView("events/details");
			//writedump(rc);
			//abort;
		</cfscript>
</cffunction>
</cfcomponent>