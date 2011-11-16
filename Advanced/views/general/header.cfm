<cfoutput>
<div id="header">
	<h1>Night Owl</h1>
	<ul>
		<li>Events</li>
		<li>Profile</li>
		<li><a href="#event.buildlink('account')#" title="edit your account">Account</a></li>
		<li id="signup"><a href="##" title="Sign Up">Sign Up</a></li>
		<li id="login">Login
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
		</li>
	</ul>
</div>
</cfoutput>