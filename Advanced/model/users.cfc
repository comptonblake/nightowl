component output="false" persistent="true" { 

property name="user_id" column="user_id" ormtype="int" fieldtype="id" generator="increment";
property name="username" column="username" length="120" ormtype="string"; 
property name="firstname" column="fname" length="120" ormtype="string"; 
property name="lastname" column="lname" length="120" ormtype="string";
property name="password" column="password" length="250" ormtype="string";
property name="email" column="email" length="120" ormtype="string";
property name="filename" column="filename" length="250" ormtype="string";
property name="salt" column="salt" length="350" ormtype="string";


<!---
<cffunction name="createuser" output="false" access="public" returntype="string" hint="Returns all users in the database, active and inactive.">

	
	<cfreturn "this is working right">
</cffunction>
--->

users function init() output=false{
 	return this;
}

}

