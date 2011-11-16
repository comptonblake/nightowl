<cfoutput>

<div id="eventcreate">
<h2>Create an Event</h2>
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
			<label for="locations">Location:</label>
			<input type="text" name="locations" placeholder="Orlando, Fl."/>
		</li>
		<li id="formdesc">
			<label for="email">Description:</label>
			<textarea  name="description" placeholder="The Event Description" rows="5" cols="55"></textarea>
		</li>
		<li>
			<input type="submit" value="Create Event"/>
		</li>
	</ul>
</form>
</div>

<div id="filterevents">
<form action="#event.buildlink('events.userposts')#" method="post" id="finduserpost">
<ul>
	<li>
		<input type="submit" value="Your Events"/>
	</li>
</ul>
</form>
</div>

<div id="events">
<ul>
	<li><a href="#event.buildlink('events.getnextevents')#" title="go to previous">Previous</a></li>
	<li><a href="#event.buildlink('events.getnextevents')#" title="go to next">next</a></li>
</ul>
		<cfloop array="#rc.events#" index="i" >
<!--- 			<cfdump var="#i.hasInvites()#"> --->
			<cfset eventid = i.getEvent_id()>
			<cfoutput>
				<div class="event">
				<div class="left">
					<p class="eventimg"><img src="includes/images/coldbox.png" /></p>
				</div>
				<div class="right">
					<h3><a href="#event.buildlink('events.geteventby')#&id=#eventid#">#i.gettitle()#</a></h3>
					<p>#i.getdescription()#</p>
					<p>#i.getDate()#</p>
					<p>#i.getTime()#</p>
					<p>#i.getLocation()#</p>
				</div>
				<cfif #i.hasInvites()# eq false>
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
		
		
		
		<!---
for(item in rc.events){
			
			
			writedump(item);
		
		}
		writedump(rc.events);
		abort;
--->
</div>





</cfoutput>