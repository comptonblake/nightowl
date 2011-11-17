<cfoutput>

<div id="header">
	<h1><a href="#event.buildlink('general')#" >Night Owl</a></h1>
	<ul>
		<li id="signupbtn"><a href="##" title="Sign Up" id="btnsignup">Sign Up</a></li>
		<li id="login"><a href="##" id="btnlogin" title="login">Login</a>
			<cfif structKeyExists(rc,"loginerrors")>
			<form action="#event.buildlink('home.login')#" method="post" id="loginForm" style="display:block;">
			<cfloop collection="#rc.loginerrors#" item="i">
				<h3 class="loginerrors">#rc.loginerrors['#i#']#</h3>
			</cfloop>
			<cfelse>
			<form action="#event.buildlink('home.login')#" method="post" id="loginForm">
			</cfif>
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
		</li>
	</ul>
</div>
</cfoutput>