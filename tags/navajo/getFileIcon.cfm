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
$Header: /cvs/farcry/core/tags/navajo/getFileIcon.cfm,v 1.10 2005/08/09 03:54:40 geoff Exp $
$Author: geoff $
$Date: 2005/08/09 03:54:40 $
$Name: milestone_3-0-1 $
$Revision: 1.10 $

|| DESCRIPTION || 
$Description: Works out which icon to use for attachments$


|| DEVELOPER ||
$Developer: Brendan Sisson (brendan@daemon.com.au)$

|| ATTRIBUTES ||
$in: $
$out:$
--->

<cfsetting enablecfoutputonly="yes">

<cfprocessingDirective pageencoding="utf-8">

<cfset theFileName=attributes.filename>
<cfset suffix="default">
<cfset pos=find(".",theFileName)>

<cfif pos>
	<cfset suffix=RemoveChars(theFileName, 1, pos)>
</cfif>

<cfswitch expression="#suffix#">
	<cfcase value="pdf">
		<cfset icon="pdf.gif">
	</cfcase>
	<cfcase value="doc,dot">
		<cfset icon="Winword.gif">
	</cfcase>
	<cfcase value="ppt">
		<cfset icon="POWERPNT.gif">
	</cfcase>
	<cfcase value="gif,jpg,jpeg,pjpeg,cpt,tiff,bmp,eps,png,tif,psd,ai">
		<cfset icon="Pbrush.gif">
	</cfcase>
	<cfcase value="mov,ra">
		<cfset icon="mov.gif">
	</cfcase>
	<cfcase value="xls,xlt,xlm">
		<cfset icon="excel.gif">
	</cfcase>
	<cfcase value="mdb,mde,mda,mdw">
		<cfset icon="Msaccess.gif">
	</cfcase>
	<cfcase value="wav,au,mid">
		<cfset icon="sound.gif">
	</cfcase>
	<cfcase value="mpp">
		<cfset icon="project.gif">
	</cfcase>
	<cfcase value="swf">
		<cfset icon="flash.gif">
	</cfcase>
	<cfcase value="scr">
		<cfset icon="screensaver.gif">
	</cfcase>
	<cfcase value="zip">
		<cfset icon="winzip_icon.gif">
	</cfcase>
	<cfcase value="exe">
		<cfset icon="exe_icon.gif">
	</cfcase>
	<cfcase value="rtf">
		<cfset icon="Write.gif">
	</cfcase>
	<cfcase value="txt,log,bat">
		<cfset icon="wordpad.gif">
	</cfcase>
	<cfcase value="htm,html,cfm,dbm,shtml,dbml,cfml,asp">
		<cfif not parameterexists(http_user_agent)>
			<cfset icon="iexplore.gif">
		<cfelseif http_user_agent does not contain "IE">
			<cfset icon="netscape.gif">
		<cfelse>
			<cfset icon="iexplore.gif">
		</cfif>
	</cfcase>
	<cfdefaultcase>
		<cfset icon="unknown.gif">
	</cfdefaultcase>
</cfswitch>

<cfset "caller.#attributes.r_stIcon#"=icon>

<cfsetting enablecfoutputonly="no">