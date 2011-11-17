<cfcomponent extends="coldbox.system.eventhandler" autowire="true">
		<cfproperty name="sessions" inject="coldbox:plugin:SessionStorage"/>
		<cfproperty name="ORMService" inject="coldbox:plugin:ORMService">
		<cfproperty name="eventsgateway" inject="model:EventsGateway"/>
		<cfproperty name="userGateway" inject="model:userGateway"/>

<cffunction name="index" returntype="any" hint="My main event">
		<cfargument name="event">
		<cfargument name="rc">
		<cfargument name="prc">
		<cfscript>
		
		param name='rc.offset' default=0;
		param name="rc.limit" default = 10;
		
			var getevents = eventsgateway.getevents( rc.offset, rc.limit );
			
			var allEvents = [];
			
			
			for( ev in getevents )
			{
				var ent = {};
				ent.title = ev.getTitle();
				ent.date = ev.getDate();
				ent.time = ev.getTime();
				ent.userId = ev.getUser_Id();
				ent.eventId = ev.getevent_Id();
				ent.description = ev.getDescription();
				//ent.userName = userGateway.getUsername(ev.getUser_id());
				ent.location = ev.getLocation();
				ent.filename = "default.png";
				
				ArrayAppend(allEvents, ent);
				
			}
			
			return arguments.event.renderData(type='json', data=allEvents);
			
				
			//return;
				//abort;
		</cfscript>
</cffunction>
</cfcomponent>