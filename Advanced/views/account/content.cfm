<cfoutput>
<div id="eventcreate">
<h2>Create an Event</h2>
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
			<input type="submit" value="Sign Up"/>
		</li>
	</ul>
</form>
</div>
</cfoutput>