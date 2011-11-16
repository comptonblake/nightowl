<cfscript>
component name="EventsGateway" cache="true" cacheTimeout="0"{

	function validateevent(){
		var errors = structnew();
		
		var checkinputs = application.cbcontroller.getPlugin("Validator");
		
		var title = checkinputs.checkMinLen(form.title,1);
			title ? "" : errors.title = "Please enter your first name";
		var date = checkinputs.checkDate(form.date);
			date ? "" : errors.date = "Please enter your last name";
		var locations = checkinputs.checkMinLen(form.locations, 1);
			locations ? "" : errors.locations = "Please enter a username with at least 8 characters";
		var description = checkinputs.checkMinLen(form.description,1);
			description ? "" : errors.description = "Please enter a correct email address";
		
		if(structcount(errors) LT 1){
			//createtheuser(form);
			return true;
		}else{
			writedump(errors);
			abort;
			return errors;
		}		
	}
	
	
	function createevents(rc, session){
		
		//grabs the plugin for the ORM service to be written and executed
		var event = application.cbcontroller.getPlugin("ORMService");
		rc.user_id = session.cbStorage.id;
		
		//creates the user that needs to be saved and where
		var setevent = event.new("events", rc);
		
		
		var saved = event.save(setevent);
		ORMflush();
			
		return saved;
	}
	
	function getevents(){
		
		//grabs the plugin for the ORM service to be written and executed
		var event = application.cbcontroller.getPlugin("ORMService");
		var query = "from events as e order by e.event_id ASC";
		
		try{
			var events = event.findAll(query=query,max=10,offset=0);
		}catch(any e){
			writedump(e);
			abort;
			return e;
		}
		
		return events;
	}
	
	function getnextevents(rc,session){
		var paginationnum = session.cbStorage.pagination;
		var paginationnum += 10;
		
		//grabs the plugin for the ORM service to be written and executed
		var event = application.cbcontroller.getPlugin("ORMService");
		var query = "from events as e order by e.event_id ASC";
		
		try{
			var events = event.findAll(query=query,max=10,offset='#paginationnum#');
			return events;
		}catch(any e){
			try{
				writedump("success");
				abort;
				var sessions = application.cbcontroller.getPlugin("SessionStorage");
				var fixes = sessions.setVar("pagination", 0);
				var events = event.findAll(query=query,max=10,offset=0);
				return events;
				
			}catch(any e){
			
				return false;
			}
		}
	}
	
	
	function getuserevents(rc,session){
		
		writedump(rc);
		writedump(session.cbstorage.id);
		
		var event = application.cbcontroller.getPlugin("ORMService");
		var user = session.cbstorage.id;
		var query = "from events as e where e.user_id = #user#"
		
		try{
			var events = event.findAll(query = query);
			return events;
		}catch(any e){
			writedump(e);
			abort;
		}
		
		//return false;
	}
	
	function inviteuser(rc,session){
		writedump(rc);
		writedump(session);
		
		var invite = application.cbcontroller.getPlugin("ORMService");
		rc.user_id = session.cbStorage.id;
		rc.event_id = rc.eventId;
		
		//creates the user that needs to be saved and where
		var setinvite = invite.new("invites", rc);
		
		try{
			var saved = invite.save(setinvite);
			ORMflush();
			return true;
		}catch(any e){
			writedump(e);
			abort;
		}

	}
	
	function uninviteuser(rc, session){
		
		
		var uninvite = application.cbcontroller.getPlugin("ORMService");
		var user = session.cbStorage.id;
		var event = rc.eventId;
		
		
		// first 20 stale inactive users 
		//ormService.deleteByQuery(query=query,max=20); 
		// 20 posts starting from my 15th entry
		var working = {user_id=user, event_id=event};
		
		try{
			var query = ''; 
			var deleted = uninvite.deleteByQuery("from invites where user_id = :user_id and event_id = :event_id", working);
			//ormService.deleteByQuery("from Post as p where p.author=:author", {author='Luis Majano'})
			//var deleted = uninvite.deleteWhere(entityName="invites",criteria={user_id="#user#",event_id="#event#"});
			ORMflush();
			//writedump(event);

		}catch(any e){
			writedump(e);
			abort;
		}
	}
	
	function geteventsbyid(rc){
		
		var events = application.cbcontroller.getPlugin("ORMService");
		var event = rc.id;
		
		try{
			var getevent = events.findIt("from events as e where e.event_id=:id", {id=1});
			return getevent;
		}catch(any e){
			writedump(e);
			abort;
		}
	
	}
	
	function sendcomment(rc,sessions){
		var comments = application.cbcontroller.getPlugin("ORMService");
		writedump(rc);
		writedump(sessions);
		
		var user_id = sessions.id;
		
		rc.user_id = user_id;
		
		//creates the user that needs to be saved and where
		var setcomment = comments.new("comments", rc);
		
		try{
			var saved = comments.save(setcomment);
			ORMflush();
			return true;
		}catch(any e){
			writedump(e);
			abort;
		}	
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
</cfscript>