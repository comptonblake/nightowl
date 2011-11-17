<cfoutput>

<div id="eventcreate">
<h2>Create an Event</h2>

<cfif structKeyExists(rc,"createerrors")>
<cfloop collection="#rc.createerrors#" item="i">
	<h3 class="errors">#rc.createerrors['#i#']#</h3>
</cfloop>
</cfif>

<form action="#event.buildlink('events.createevent')#" method="post" id="createevent">
	<ul>
		<li>
			<label for="title">Title:</label>
			<input type="text" name="title" placeholder="Title of Event"/>
		</li>
		<li class="floatleft">
			<label for="date">Date:</label>
			<input type="text" name="date" placeholder="Date"/>
		</li>
		<li class="floatleft" id="selects">
			<label for="time">Time:</label>
			<select name="time">
				<option>5:00pm</option>
				<option>6:00pm</option>
				<option>7:00pm</option>
				<option>8:00pm</option>
				<option>9:00pm</option>
				<option>10:00pm</option>
				<option>11:00pm</option>
				<option>12:00am</option>
				<option>1:00am</option>
				<option>2:00am</option>
				<option>3:00am</option>
				<option>4:00am</option>
			</select>
		</li>
		<li class="floatleft">
			<label for="location">Location:</label>
			<input type="text" name="location" placeholder="Orlando, Fl."/>
		</li>
		<li id="formdesc">
			<label for="email">Description:</label>
			<textarea  name="description" placeholder="The Event Description" rows="5" cols="55" ></textarea>
		</li>
		<li>
			<input type="submit" value="Create Event"/>
		</li>
	</ul>
</form>
</div>

<div id="filterevents">
<ul>
	<li><a href="#event.buildlink('events.userposts')#">Your Events</a></li>
	<li><a href="#event.buildlink('events.invitedevents')#">Invited Events</a></li>
	<li><a href="#event.buildlink('events.alleventsview')#">View All Events</a></li>
</ul>

</div>

<div id="events">
<!---
<ul>
	<li><a href="#event.buildlink('events.getnextevents')#" title="go to previous">Previous</a></li>
	<li><a href="#event.buildlink('events.getnextevents')#" title="go to next">next</a></li>
</ul>
--->
		
		<cfloop array="#rc.events#" index="i" >
			<cfset eventid = i.getEvent_id()>
			<cfoutput>
			<cfset user="#i.getUsers()#">
			<cfset image = "#user[1].getFilename()#">
				<div class="event">
				<div class="left">
					<p class="eventimg"><img src="includes/images/users/#image#" /></p>
				</div>
				<div class="right">
					<h3><a href="#event.buildlink('events.geteventby')#&id=#eventid#">#i.gettitle()#</a></h3>
					<p>#i.getdescription()#</p>
					<p class="details">#i.getDate()#</p>
					<p class="details">#i.getTime()#</p>
					<p class="details">#i.getLocation()#</p>
				</div>
				
				
				<cfset blah = getModel('eventsgateway')>
				<cfset inviteexists  = blah.checkinvite(#session.cbStorage.id#,i.getEvent_id())>
				
				<cfif ArrayIsEmpty(#inviteexists#)>
					<form action="#event.buildlink('events.userinvite')#" method="post" id="invite">
						<ul>
							<li>
								<input type="hidden" name="eventId" value="#i.getEvent_id()#"/>
							</li>
							<li>
								<input type="submit" value="Your going"/>
							</li>
						</ul>
					</form>
				<cfelse>
					<form action="#event.buildlink('events.useruninvited')#" method="post" id="invite">
							<ul>
								<li>
									<input type="hidden" name="eventId" value="#i.getEvent_id()#"/>
								</li>
								<li>
									<input type="submit" value="Not Going"/>
								</li>
							</ul>
						</form>
				</cfif>
				
			</div>
			</cfoutput>
			
		</cfloop>
		
		
		<p class="loadmore"><a href="#event.buildlink('events.loadmore')#">LOAD MORE EVENTS</a></p>
		
		<!---
for(item in rc.events){
			
			
			writedump(item);
		
		}
		writedump(rc.events);
		abort;
--->
</div>





</cfoutput>