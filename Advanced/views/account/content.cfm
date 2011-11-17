<cfoutput>
<div id="eventcreate">
<h2>Create an Event</h2>
<cfif structKeyExists(rc,"accounterrors")>
<cfloop collection="#rc.accounterrors#" item="i">
	<h3 class="errors">#rc.accounterrors['#i#']#</h3>
</cfloop>
</cfif>
<form action="#event.buildlink('account.editinfo')#" enctype="multipart/form-data" method="post" id="signupForm">
	<ul>
		<li>
			<label for="firstname">First Name:</label>
			<input type="text" name="firstname" value="#rc.userinfo.firstname#"/>
		</li>
		<li>
			<label for="lname">Last Name:</label>
			<input type="text" name="lastname" value="#rc.userinfo.lastname#"/>
		</li>
		<li>
			<label for="username">Username:</label>
			<input type="text" name="username" value="#rc.userinfo.username#"/>
		</li>
		<li>
			<label for="imgupload">Profile Image</label>
			<input type="file" name="filename" value="find your file"/>
		</li>
		<li>
			<input type="submit" value="Edit Account"/>
		</li>
	</ul>
</form>
</div>
</cfoutput>