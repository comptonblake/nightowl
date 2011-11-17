<cfset event.showdebugpanel("false")>
<cfcontent type="application/rss+xml"><cfoutput>#trim(renderView())#</cfoutput>