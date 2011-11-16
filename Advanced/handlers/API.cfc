<cfcomponent extends="coldbox.system.eventhandler" autowire="true">
		<cfproperty name="sessions" inject="coldbox:plugin:SessionStorage"/>
		<cfproperty name="ORMService" inject="coldbox:plugin:ORMService">
		<cfproperty name="eventsgateway" inject="model:EventsGateway"/>

<cffunction name="index" returntype="any" hint="My main event">
		<cfargument name="event">
		<cfargument name="rc">
		<cfargument name="prc">
		<cfscript>
		
		
		/*var checklogin = sessions.getStorage();
			
			if(structcount(checklogin) lt 2){
				setNextEvent("home");
			}
			
			rc.userinfo = sessions.getStorage();*/

			var getevents = eventsgateway.getevents();
			
			return serializeJSON(getevents[9]);
				
			//return;
				//abort;
		</cfscript>
</cffunction>
</cfcomponent>