<!--- @@Copyright: Daemon Pty Limited 2002-2008, http://www.daemon.com.au --->
<!--- @@License:
    This file is part of FarCry.

    FarCry is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    FarCry is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with FarCry.  If not, see <http://www.gnu.org/licenses/>.
--->
<!---
|| VERSION CONTROL ||
$Header: /cvs/farcry/core/webtop/reporting/reportingMenuFrame.cfm,v 1.14 2005/08/09 03:54:40 geoff Exp $
$Author: geoff $
$Date: 2005/08/09 03:54:40 $
$Name: milestone_3-0-1 $
$Revision: 1.14 $

|| DESCRIPTION || 
$Description: Displays menu items for reporting section in Farcry. $


|| DEVELOPER ||
$Developer: Brendan Sisson (brendan@daemon.com.au)$

|| ATTRIBUTES ||
$in: $
$out:$
--->

<cfsetting enablecfoutputonly="Yes">

<cfprocessingDirective pageencoding="utf-8">

<cfimport taglib="/farcry/core/tags/misc/" prefix="misc">

<!--- check permissions --->
<cfscript>
	iStatsTab = application.security.checkPermission(permission="ReportingStatsTab");
	iAuditTab = application.security.checkPermission(permission="ReportingAuditTab");
	iDeveloper = application.security.checkPermission(permission="Developer");
</cfscript>

<cfoutput>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html dir="#session.writingDir#" lang="#session.userLanguage#">
<head>
	<title>reportingMenuFrame</title>
	<misc:cacheControl>
	<LINK href="../css/overviewFrame.css" rel="stylesheet" type="text/css">
	<meta content="text/html; charset=UTF-8" http-equiv="content-type">
</head>

<body>

<cfparam name="url.type" default="stats">

<!--- display menu --->
<div id="frameMenu">
	<cfswitch expression="#url.type#">
		<cfcase value="stats">	
			<!--- permission check --->
			<cfif iStatsTab eq 1>
				<div class="frameMenuTitle">#application.rb.getResource("general")#</div>
				<div class="frameMenuItem"><span class="frameMenuBullet">&raquo;</span> <a href="statsOverview.cfm" class="frameMenuItem" target="editFrame">#application.rb.getResource("overviewReport")#</a></div>
				<div class="frameMenuItem"><span class="frameMenuBullet">&raquo;</span> <a href="statsMostPopular.cfm" class="frameMenuItem" target="editFrame">#application.rb.getResource("viewSummary")#</a></div>
				<div class="frameMenuItem"><span class="frameMenuBullet">&raquo;</span> <a href="statsReferer.cfm" class="frameMenuItem" target="editFrame">#application.rb.getResource("refererSummary")#</a></div>
				<div class="frameMenuItem"><span class="frameMenuBullet">&raquo;</span> <a href="statsLocale.cfm" class="frameMenuItem" target="editFrame">#application.rb.getResource("localeSummary")#</a></div>
				<div class="frameMenuItem"><span class="frameMenuBullet">&raquo;</span> <a href="statsOS.cfm" class="frameMenuItem" target="editFrame">#application.rb.getResource("OSsummary")#</a></div>
				<div class="frameMenuItem"><span class="frameMenuBullet">&raquo;</span> <a href="statsBrowsers.cfm" class="frameMenuItem" target="editFrame">#application.rb.getResource("browserSummary")#</a></div>		
				
				<div class="frameMenuTitle">#application.rb.getResource("sessions")#</div>
				<div class="frameMenuItem"><span class="frameMenuBullet">&raquo;</span> <a href="statsVisitors.cfm" class="frameMenuItem" target="editFrame">#application.rb.getResource("sessionSummary")#</a></div>
				<div class="frameMenuItem"><span class="frameMenuBullet">&raquo;</span> <a href="statsVisitorPaths.cfm" class="frameMenuItem" target="editFrame">#application.rb.getResource("sessionPath")#s</a></div>
				<div class="frameMenuItem"><span class="frameMenuBullet">&raquo;</span> <a href="statsWhosOn.cfm" class="frameMenuItem" target="editFrame">#application.rb.getResource("whoOnNow")#</a></div>
				
				<div class="frameMenuTitle">#application.rb.getResource("keyWordSearch")#</div>
				<div class="frameMenuItem"><span class="frameMenuBullet">&raquo;</span> <a href="statsGoogle.cfm" class="frameMenuItem" target="editFrame">Google</a></div>
				
				<div class="frameMenuTitle">#application.rb.getResource("inSiteSearches")#</div>
				<div class="frameMenuItem"><span class="frameMenuBullet">&raquo;</span> <a href="statsSearches.cfm" class="frameMenuItem" target="editFrame">#application.rb.getResource("recentSearches")#</a></div>
				<div class="frameMenuItem"><span class="frameMenuBullet">&raquo;</span> <a href="statsSearchesNoResults.cfm" class="frameMenuItem" target="editFrame">#application.rb.getResource("noResultSearches")#</a></div>
				<div class="frameMenuItem"><span class="frameMenuBullet">&raquo;</span> <a href="statsSearchesMostPopular.cfm" class="frameMenuItem" target="editFrame">#application.rb.getResource("mostPopularSearches")#</a></div>
				
				<cfif iDeveloper eq 1>
					<div class="frameMenuTitle">#application.rb.getResource("maintenance")#</div>
					<div class="frameMenuItem"><span class="frameMenuBullet">&raquo;</span> <a href="statsClear.cfm" class="frameMenuItem" target="editFrame" onClick="return confirm('#application.rb.getResource("confirmDeleteAllRecs")#');">#application.rb.getResource("clearStatsLog")#</a></div>
				</cfif>
			</cfif>
		</cfcase>
		
		<cfcase value="audit">
			<!--- permission check --->
			<cfif iAuditTab eq 1>
				<div class="frameMenuTitle">#application.rb.getResource("loginActivity")#</div>
				<div class="frameMenuItem"><span class="frameMenuBullet">&raquo;</span> <a href="auditLogins.cfm" class="frameMenuItem" target="editFrame">#application.rb.getResource("allLogins")#</a></div>
				<div class="frameMenuItem"><span class="frameMenuBullet">&raquo;</span> <a href="auditFailedLogins.cfm" class="frameMenuItem" target="editFrame">#application.rb.getResource("failedLogins")#</a></div>
				<div class="frameMenuItem"><span class="frameMenuBullet">&raquo;</span> <a href="auditUserActivity.cfm?graph=day" class="frameMenuItem" target="editFrame">#application.rb.getResource("dailyUserLoginActivity")#</a></div>
				<div class="frameMenuItem"><span class="frameMenuBullet">&raquo;</span> <a href="auditUserActivity.cfm?graph=week" class="frameMenuItem" target="editFrame">#application.rb.getResource("weeklyUserLoginActivity")#</a></div>
				
				<div class="frameMenuTitle">#application.rb.getResource("userActivitiy")#</div>
				<div class="frameMenuItem"><span class="frameMenuBullet">&raquo;</span> <a href="auditUser.cfm" class="frameMenuItem" target="editFrame">#application.rb.getResource("userActivitiy")#</a></div>
			</cfif>
		</cfcase>
	</cfswitch>
	
</div>

</body>
</html>
</cfoutput>
<cfsetting enablecfoutputonly="No">
