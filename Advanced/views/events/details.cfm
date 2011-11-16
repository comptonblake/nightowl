<cfoutput>
<h2>This should be working properly :)</h2>
<div id="events">
			<cfoutput>
				<div class="event">
				<div class="left">
					<p class="eventimg"><img src="includes/images/coldbox.png" /></p>
				</div>
				<div class="right">
					<h3>#rc.events.gettitle()#</h3>
					<p>#rc.events.getdescription()#</p>
					<p>#rc.events.getDate()#</p>
					<p>#rc.events.getTime()#</p>
					<p>#rc.events.getLocation()#</p>
				</div>
				<cfif #rc.events.hasInvites()# eq false>
					<form action="#event.buildlink('events.userinvite')#" method="post" id="invite">
						<ul>
							<li>
								<input type="hidden" name="eventId" value="#rc.events.getEvent_id()#"/>
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
								<input type="hidden" name="eventId" value="#rc.events.getEvent_id()#"/>
							</li>
							<li>
								<input type="submit" value="Not Going"/>
							</li>
						</ul>
					</form>

				</cfif>
				</div>
			</cfoutput>
<!--- 			<cfdump var="#rc.events#"> --->
			<cfset eventid = rc.events.getEvent_id()>
			<form action="#event.buildlink('events.comment')#&id=#eventid#" method="post" id="comment">
				<ul>
					<li>
						<label>Comment:</label>
						<textarea draggable="false" cols="20" rows="10" id="commentbox" name="comment"></textarea>
						<input type="hidden" name="event_id" value="#rc.events.getEvent_id()#"
					</li>
					<li>
						<input type="submit" value="Comment"/>
					</li>
				</ul>
			</form> 			
</div>

<div id="comments">
<h2>Comments</h2>
<!--- <cfdump var="#rc.comments.getComment()#"> --->
<cfloop array="#rc.comments#" index="i" >
	<div class="comment">
		<cfset index = 1>
		<p>#i.getComment()#</p>
	</div>

</cfloop>
</div>


</cfoutput>