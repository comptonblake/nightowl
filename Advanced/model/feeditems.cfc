<cfcomponent name="feeditems" hint="A feed items data object">

  <cfset variables.instance = structNew()/>
  <cfset variables.instance.dns = "owl_data"/>

  <cffunction name="init" access="public" returntype="feeditems" output="false">
    <cfreturn this>
  </cffunction>

  <---  Fetch data from a database --->
  <cffunction name="generateItems" access="public" returntype="query" output="false">
    <cfset var returnQuery = ""/>
    <cftry>
      <---  Query the cfartgallery database and save results to a variable --->
      <cfquery name="returnQuery" datasource="#variables.instance.dns#">
        SELECT title, description,eventuate,eventtime, location, eventdate, event_id
        FROM events
        ORDER BY eventdate DESC
      </cfquery>
      <---  If the database query fails we create an empty query --->
      <cfcatch type="Database">
        <cfset returnQuery = QueryNew("orderid","VarChar")/>
      </cfcatch>
    </cftry>
    <cfreturn returnQuery/>
  </cffunction>

  <---  Map database column names to feed item elements --->
  <cffunction name="mapItems" access="public" returntype="struct" output="false">
    <cfset var returnMap = StructNew()/>
    <cfset returnMap.category_tag = "title"/>
    <cfset returnMap.description = "description"/>
    <cfset returnMap.guid_string = "event_id"/>
    <cfset returnMap.title = "title"/>
    <cfset returnMap.pubDate= "eventdate"/>
    <cfreturn returnMap/>
  </cffunction>

</cfcomponent>