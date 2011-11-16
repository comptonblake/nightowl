component output="false" persistent="true" { 

property name="comment_id" column="comment_id" ormtype="int" fieldtype="id" generator="increment";
property name="event_id" column="event_id" ormtype="int";
property name="user_id" column="user_id" ormtype="int"; 
property name="comment" column="comment" ormtype="string";


property name="events" type="array" fieldtype="many-to-one" cfc="events" fkcolumn="event_id";
<!---
<cffunction name="createuser" output="false" access="public" returntype="string" hint="Returns all users in the database, active and inactive.">

	
	<cfreturn "this is working right">
</cffunction>
--->

comments function init() output=false{
 	return this;
}

}