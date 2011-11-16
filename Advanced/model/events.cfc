component output="false" persistent="true" { 

property name="event_id" column="event_id" ormtype="int" fieldtype="id" generator="increment";
property name="user_id" column="user_id" ormtype="int" ; 
property name="title" column="title" length="250" ormtype="string"; 
property name="date" column="eventdate" length="120" ormtype="string";
property name="time" column="eventtime" length="10" ormtype="string";
property name="location" column="location" length="250" ormtype="string";
property name="description" column="description" ormtype="string";

property name="users" type="array" fieldtype="one-to-many" cfc="users" fkcolumn="user_id";
property name="invites" type="array" fieldtype="one-to-many" cfc="invites" fkcolumn="event_id";
property name="comments" type="array" fieldtype="one-to-many" cfc="comments" fkcolumn="event_id";

<!---
<cffunction name="createuser" output="false" access="public" returntype="string" hint="Returns all users in the database, active and inactive.">

	
	<cfreturn "this is working right">
</cffunction>
--->

events function init() output=false{
 	return this;
}

}