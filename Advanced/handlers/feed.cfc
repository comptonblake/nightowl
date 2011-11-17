<cfcomponent extends="coldbox.system.eventhandler" autowire="true">
		<cfproperty name="sessions" inject="coldbox:plugin:SessionStorage"/>
		<cfproperty name="ORMService" inject="coldbox:plugin:ORMService">
		<cfproperty name="eventsgateway" inject="model:EventsGateway"/>
		<cfproperty name="usergateway" inject="model:UserGateway">

<cffunction name="index" returntype="void" output="false" hint="My main event">
		<cfargument name="event">
		<cfargument name="rc">
		<cfargument name="prc">
	<cfscript>
		param name='rc.offset' default=0;
		param name="rc.limit" default = 10;
		
			var getevents = eventsgateway.getevents(rc.offset, rc.limit);
			var allEvents = {};
			
			for( ev in getevents )
			{
				
					
				 allEvents.item = ArrayNew(1); 
       			 allEvents.item[1] = StructNew(); 
        		 allEvents.item[1].description = StructNew(); 
       			 allEvents.item[1].description.value = ev.getTitle(); 
       			 allEvents.item[1].link = ev.getDate(); 
       			 allEvents.item[1].pubDate = Now(); 
       			 allEvents.item[1].title = StructNew();
       			 allEvents.item[1].title.value = ev.getDescription(); 
			}
			
			allEvents.link = "this is a link"; 
        	allEvents.title = "Night Owl RSS feed"; 
        	allEvents.description = "working on rss feed"; 
        	allEvents.pubDate = Now(); 
        	allEvents.version = "rss_2.0"; 
		
		rc.feed = allEvents;
		
		event.setView("vwDisplayFeed");
	</cfscript>
  </cffunction>

</cfcomponent>