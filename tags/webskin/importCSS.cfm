<cfsetting enablecfoutputonly="yes">
<!--- 
|| LEGAL ||
$Copyright: Daemon Pty Limited 1995-2003, http://www.daemon.com.au $
$License: Released Under the "Common Public License 1.0", http://www.opensource.org/licenses/cpl.php$ 

|| VERSION CONTROL ||
$Header: /cvs/farcry/farcry_core/tags/webskin/importCSS.cfm,v 1.9 2003/12/08 05:41:49 paul Exp $
$Author: paul $
$Date: 2003/12/08 05:41:49 $
$Name: milestone_2-1-2 $
$Revision: 1.9 $

|| DESCRIPTION || 
Import CSS for templates based on site tree

|| DEVELOPER ||
Geoff Bowers (modius@daemon.com.au)
Brendan Sisson (brendan@daemon.com.au)

|| ATTRIBUTES ||
in: type (import or link)
out:
--->

<!--- optional attributes --->
<cfparam name="attributes.type" default="import">

<!--- get style sheets --->
<cfif IsDefined("request.navid")>
	<cfscript>
	// get navigation elements to root
	qAncestors = request.factory.oTree.getAncestors(objectid=request.navid, bIncludeSelf=true);
	</cfscript>
	
	<cfset lCSS = "">
	
	<!--- loop through and determine which ones have CSS objects --->
	<cfloop query="qAncestors">
		<!--- check for style sheet --->
		<cfquery datasource="#application.dsn#" name="qCheck">
		SELECT dmCSS.objectid, dmCSS.filename
		FROM #application.dbowner#dmCSS, #application.dbowner#dmNavigation_aObjectIDs
		WHERE 
			dmCSS.objectid = dmNavigation_aObjectIDs.data
			AND dmNavigation_aObjectIDs.objectid = '#objectid#'
		</cfquery>
		
		<!--- append css to list --->
		<cfif qCheck.recordcount>
			<!--- if more than one item in list append --->
			<cfif len(lCSS)>
				<cfset lCSS = listappend(lCSS,qCheck.filename)>
			<cfelse>
				<cfset lCSS = qCheck.filename>
			</cfif>
		</cfif>
	</cfloop>
</cfif>

<!--- output stylesheets --->
<cfif attributes.type eq "import">
	<cfoutput>
	<!-- FOUC'd hack -->
	<script type="text/javascript"> </script>
	<!-- imported style sheets -->
	<style type="text/css" media="all"></cfoutput>
	<!--- loop through style sheets and import --->	
	<cfloop list="#lCSS#" index="styleSheet">
		<cfoutput>
			@import "#application.url.webroot#/css/#styleSheet#";
		</cfoutput>
	</cfloop>
	<cfoutput>	</style></cfoutput>
<cfelse>
	<!--- loop through style sheets and link --->
	<cfloop list="#lCSS#" index="styleSheet">
			<cfoutput><link href="#application.url.webroot#/css/#styleSheet#" rel="stylesheet" type="text/css"></cfoutput>
	</cfloop>
</cfif>

<cfsetting enablecfoutputonly="no">