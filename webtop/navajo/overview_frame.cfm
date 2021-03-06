<cfsetting enablecfoutputonly="Yes" showdebugoutput="No">
<cfprocessingDirective pageencoding="utf-8">
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
$Header: /cvs/farcry/core/webtop/navajo/overview_frame.cfm,v 1.10 2005/08/28 01:34:54 geoff Exp $
$Author: geoff $
$Date: 2005/08/28 01:34:54 $
$Name: milestone_3-0-1 $
$Revision: 1.10 $

|| DESCRIPTION || 
$Description: 	Iframe for the site tree overview page.  
				Gradually trying to refactor this area but its sensitive to change. GB $

|| DEVELOPER ||
$Developer: Geoff Bowers (modius@daemon.com.au)$
--->
<!--- import tag libraries --->
<cfimport taglib="/farcry/core/tags/navajo" prefix="nj">
<cfimport taglib="/farcry/core/tags/admin" prefix="admin" />

<cftry>
<!--- TODO: not sure how beneficial this lock is. not sure of its history either :( GB --->
<cflock timeout="0" throwontimeout="Yes" name="refreshLockout_#session.URLToken#" type="EXCLUSIVE">
	<!--- include icon image paths. sets variables.customIcons (not great GB) --->
	<cfinclude template="_customIcons.cfm">
	
	<cfoutput>
	<html dir="#session.writingDir#" lang="#session.userLanguage#">
	<HEAD>
	<TITLE>#application.rb.getResource("sitetree.headings.overviewTree@text","Overview Tree")#</TITLE>
	<LINK href="#application.url.farcry#/css/overviewFrame.css" rel="stylesheet" type="text/css">
	<meta content="text/html; charset=UTF-8" http-equiv="content-type">
	</HEAD>
		
	<body>
		<div id="tree">
			</cfoutput>
				<nj:Overview customIcons="#customIcons#">
			<cfoutput>
		</div>
	</body>
	</html>
	</cfoutput>
</cflock>

	<cfcatch type="Lock">
		<admin:resource key="sitetree.messages.overviewTreeLoadingBlurb@text">
			<cfoutput>
				<p>The system has detected the <b>Overview Tree</b> is already loading.</p>
				<p>The <b>Overview Tree</b> cannot be loaded more than once per user at a time.</p>
				<p>You are probably receiving this error because you have pushed the refresh button half way through loading. Pressing the refresh button in the middle of loading can have a significant performance impact on the website as your previous requests must be serviced before your new requests.  Therefore, we have implemented this restriction.</p>
				<p>You will now have to wait for your previous request to complete before you will be allowed to reload this screen.</p>
				<p><b>Please try again in 30 seconds.</b></p>
			</cfoutput>
		</admin:resource>
		<cfoutput>
		<p><a href="">Refresh Tree</a></p>
		</cfoutput>
	</cfcatch>
</cftry>

<cfsetting enablecfoutputonly="No">
