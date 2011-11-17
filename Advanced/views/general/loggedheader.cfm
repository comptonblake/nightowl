<cfoutput>
<div id="header">
	<h1><a href="#event.buildlink('general')#" >Night Owl</a></h1>
	<ul>
		<li><img  />#session.cbStorage.username#</li>
		<li><a href="#event.buildlink('events')#" title="Events">Events</a></li>
		<li><a href="#event.buildlink('account')#" title="edit your account">Account</a></li>
		<li><a href="#event.buildlink('home.logout')#" title="Logout">Log Out</a></li>
	</ul>
</div>
</cfoutput>