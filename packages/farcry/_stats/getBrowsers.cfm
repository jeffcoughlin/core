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
$Header: /cvs/farcry/core/packages/farcry/_stats/getBrowsers.cfm,v 1.7 2005/08/09 03:54:39 geoff Exp $
$Author: geoff $
$Date: 2005/08/09 03:54:39 $
$Name: milestone_3-0-1 $
$Revision: 1.7 $

|| DESCRIPTION || 
$Description: Shows browser types used$


|| DEVELOPER ||
$Developer: Brendan Sisson (brendan@daemon.com.au)$

|| ATTRIBUTES ||
$in: $
$out:$
--->

<!--- get maxrows if not defined --->
<cfif arguments.maxRows eq "all">
	<cfquery datasource="#arguments.dsn#" name="qMax">
		SELECT count(logid) as maxrows
		FROM #application.dbowner#stats
	</cfquery>
	<cfset arguments.maxrows = qMax.maxrows>
</cfif>

<!--- get browsers from stats --->
<cfquery name="qVisitors" datasource="#arguments.dsn#" maxrows="#arguments.maxRows#">
	select browser, count(distinct sessionid) as views
	from #application.dbowner#stats
	WHERE 1=1
	<cfif arguments.dateRange neq "all">
		AND logDateTime > #dateAdd("#arguments.dateRange#",-1,now())#
	</cfif>
	AND browser <> 'unknown'
	GROUP BY browser	
	ORDER BY views DESC
</cfquery>
