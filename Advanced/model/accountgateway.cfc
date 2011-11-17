
<cfcomponent name="AccountGateway" cache="true" cacheTimeout="0">
<cfscript>
function validateuserinfo(rc){
	
	var errors = structnew();
		
		var checkinputs = application.cbcontroller.getPlugin("Validator");
		
		var firstname = checkinputs.checkMinLen(form.firstname,1);
			firstname ? "" : errors.firstname = "Please enter your first name";
		var lastname = checkinputs.checkMinLen(form.lastname,1);
			lastname ? "" : errors.lastname = "Please enter your last name";
		var username = checkinputs.checkMinLen(form.username, 1);
			username ? "" : errors.username = "Please enter a username with at least 8 characters";	
	
	return errors;
}
</cfscript>
<cffunction name="updateuserinfo" access="public" returnType="any">
		<cfargument name="rc" required="true">
		<cfargument name="sessions" required="true">
		
		<cfif #form.filename# != "">
			<cffile action="upload" fileField="form.filename" result="file" destination="../includes/images/users" nameconflict="overwrite">
			
			<cfset image = "../includes/images/users/" & file.serverFile>
	<!--- 		<cfdump var="#image#"> --->
			<cfimage action="read" source="#image#" name="newimage">
			<cfset imagescaletofit(newimage, 50, 50)>
			<cfimage
	            action = "write"
	            destination = "#image#"
	            source = "#newimage#"
	            overwrite = "yes">
	        <cfscript>
	       	 var user = application.cbcontroller.getPlugin("SessionStorage");
	       	 user.setVar('filename',file.serverFile);
	        </cfscript>
	            
        </cfif> 
       
        <cfscript>
        
        
    	//grabs the plugin for the ORM service to be written and executed
		var user = application.cbcontroller.getPlugin("ORMService");
		
		var theuser = user.findIt("from users as u where u.user_id = :id", { id=sessions.id});
		
		var setfirstname = theuser.setFirstname(rc.firstname);
		var setlastname = theuser.setLastname(rc.lastname);
		var setusername = theuser.setUsername(rc.username);
		if(form.filename == ""){
			var setfilename = theuser.setFilename("default.png");
		}else{
			var setfilename = theuser.setFilename(file.serverFile);
		}
		
		
		//saves the user using the ORMservice
		ORMflush();
    
		return true;
        
        
        </cfscript> 
		<cfreturn true>
</cffunction>
</cfcomponent>
