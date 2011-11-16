<cfcomponent extends="coldbox.system.eventhandler" autowire="true">
		<cfproperty name="sessions" inject="coldbox:plugin:SessionStorage"/>
		<cfproperty name="ORMService" inject="coldbox:plugin:ORMService">
		<cfproperty name="accountgateway" inject="model:AccountGateway"/>

<cffunction name="index" returntype="void" output="false" hint="My main event">
		<cfargument name="event">
		<cfargument name="rc">
		<cfargument name="prc">
		<cfscript>
			
			var checklogin = sessions.getStorage();
			
			if(structcount(checklogin) lt 2){
				setNextEvent("home");
			}
			
			rc.userinfo = sessions.getStorage();
			event.setView("account/content");
		</cfscript>
</cffunction>

<cffunction name="editinfo" returnType="void" output="false" hint="edit the users account information">
	<cfargument name="event">
	<cfargument name="rc">
	<cfargument name="prc">
	
	<cfscript>
		var validateinfo = accountgateway.validateuserinfo(rc);
		
		if(structCount(validateinfo) lt 1){
			var saveuserinfo = accountgateway.updateuserinfo(rc, sessions.getStorage());
		}else{
			//display errors here please!
		}
		
		rc.userinfo = sessions.getStorage();
		event.setView("account/content");
	</cfscript>	
		

</cffunction>
</cfcomponent>