<!--- 
|| LEGAL ||
$Copyright: Daemon Pty Limited 1995-2003, http://www.daemon.com.au $
$License: Released Under the "Common Public License 1.0", http://www.opensource.org/licenses/cpl.php$

|| VERSION CONTROL ||
$Header: /cvs/farcry/farcry_core/packages/farcry/_versioning/approveEmail_approved_dd.cfm,v 1.8 2003/11/05 04:46:09 tom Exp $
$Author: tom $
$Date: 2003/11/05 04:46:09 $
$Name: milestone_2-1-2 $
$Revision: 1.8 $

|| DESCRIPTION || 
$Description: sends email for approved news type objects $
$TODO: $

|| DEVELOPER ||
$Developer: Brendan Sisson (brendan@daemon.com.au) $

|| ATTRIBUTES ||
$in: $
$out:$
--->

<cfsetting enablecfoutputonly="Yes">

<cfimport taglib="/farcry/fourq/tags/" prefix="q4">

<!--- get object details --->
<q4:contentobjectget objectID="#arguments.objectID#" r_stObject="stObj">

<!--- get dmProfile object --->
<cfscript>
o_profile = createObject("component", application.types.dmProfile.typePath);
stProfile = o_profile.getProfile(userName=stObj.lastupdatedby);
</cfscript>

<!--- send email to lastupdater to let them know object is approved --->
<cfif stProfile.emailAddress neq "" and stProfile.bReceiveEmail>

    <cfif isdefined("session.dmProfile.emailAddress") and session.dmProfile.emailAddress neq "">
        <cfset fromEmail = session.dmProfile.emailAddress>
    <cfelse>
        <cfset fromEmail = stProfile.emailAddress>
    </cfif>

<cfmail to="#stProfile.emailAddress#" from="#fromEmail#" subject="#application.config.general.sitetitle# - Object Approved">
Hi <cfif len(stProfile.firstName) gt 0>#stProfile.firstName#<cfelse>#stProfile.userName#</cfif>,

Your object "<cfif stObj.title neq "">#stObj.title#<cfelse>undefined</cfif>" has been approved.

<cfif arguments.comment neq "">
Comments added on status change:
#arguments.comment#
</cfif>

</cfmail>

</cfif>

<cfsetting enablecfoutputonly="no">