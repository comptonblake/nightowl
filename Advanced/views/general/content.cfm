<cfoutput>


<cfif structKeyExists(rc,"signuperrors")>
<div id="signup" style="display:block">
<cfloop collection="#rc.signuperrors#" item="i">
	<h3 class="errors">#rc.signuperrors['#i#']#</h3>
</cfloop>
	<!---
<cfdump var="#rc#">
	<cfdump var="#rc.signuperrors#">
--->
<!--- 	<h3 class="errors">#rc.signuperrors#</h3> --->
<cfelse>
<div id="signup">
</cfif>

<form action="#event.buildlink('home.signup')#" method="post" id="signupForm">
	<ul>
		<li>
			<label for="fname">First Name:</label>
			<input type="text" name="firstname" placeholder="First Name"/>
		</li>
		<li>
			<label for="lname">Last Name:</label>
			<input type="text" name="lastname" placeholder="Last Name"/>
		</li>
		<li>
			<label for="username">Username:</label>
			<input type="text" name="username" placeholder="Username"/>
		</li>
		<li>
			<label for="password">Password:</label>
			<input type="password" name="password" placeholder="Password"/>
		</li>
		<li>
			<label for="email">Email:</label>
			<input type="text" name="email" placeholder="Your Email"/>
		</li>
		<li>
			<input type="submit" value="Sign Up"/>
		</li>
	</ul>
</form>
<h2>Sign Up for Free</h2>
<h3>Get ready to leave <span>foursquare</span>, <span>Facebook</span>, <psan>twitter</span>, <span>Meet Up</span>.</h3>
<p>Sign up today and receive free event specials.</p>
<p>We are pretty sure this already exists.</p>
<p>So why not just start today and find out how amazing this service is. It might just blow your mind.</p>
</div>

<div id="splash">
	<div id="innerSplash">
	
	</div>
</div>

<div id="eventdriver">
	
</div>

<div id="login">
<h2>Login</h2>
<!---
<form action="#event.buildlink('home.login')#" method="post" id="loginForm">
	<ul>
		<li>
			<label for="email">Email:</label>
			<input type="text" name="email" placeholder="Your Email Address"/>
		</li>
		<li>
			<label for="password">Password:</label>
			<input type="password" name="password" placeholder="password"/>
		</li>
		<li>
			<input type="submit" value="Log in"/>
		</li>
	</ul>
</form>
--->
</div>
<script src="includes/javascript/api.js" type="text/javascript"></script>
</cfoutput>