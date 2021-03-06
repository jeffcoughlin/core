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
$Header: /cvs/farcry/core/webtop/reporting/statsVisitors.cfm,v 1.6 2005/08/17 03:28:39 pottery Exp $
$Author: pottery $
$Date: 2005/08/17 03:28:39 $
$Name: milestone_3-0-1 $
$Revision: 1.6 $

|| DESCRIPTION || 
Shows view statistics for chosen object in a number of formats

|| DEVELOPER ||
Brendan Sisson (brendan@daemon.com.au)

|| ATTRIBUTES ||
in: 
out:
--->
<cfsetting enablecfoutputonly="yes" requestTimeOut="600">

<cfprocessingDirective pageencoding="utf-8">

<!--- set up page header --->
<cfimport taglib="/farcry/core/tags/admin/" prefix="admin">
<cfimport taglib="/farcry/core/tags/security/" prefix="sec" />

<admin:header writingDir="#session.writingDir#" userLanguage="#session.userLanguage#">

<sec:CheckPermission error="true" permission="ReportingStatsTab">
	<!--- i18n: get week starts for later use --->
	<cfset weekStartDay=application.thisCalendar.weekStarts(session.dmProfile.locale)>

	<cfimport taglib="/farcry/core/packages/fourq/tags/" prefix="q4">
	<cfoutput>
	<h3>#application.rb.getResource("sessionPerHourLast3Days")#</h3>
	</cfoutput>
	
	<!--- get page log entries --->
	<cfscript>
	q1 = application.factory.oStats.getVisitorStatsByDay(day=now());
	q2 = application.factory.oStats.getVisitorStatsByDay(day=now()-1);
	q3 = application.factory.oStats.getVisitorStatsByDay(day=now()-2);
	</cfscript>
	
	<!--- show graph --->
	<cfoutput>
	<cfchart 
		chartHeight="400" 
		chartWidth="600" 
		scaleFrom="0" 
		showXGridlines = "yes" 
		showYGridlines = "yes"
		seriesPlacement="default"
		showBorder = "no"
		fontsize="12"
		labelFormat = "number"
		xAxisTitle = "#application.rb.getResource("Hour")#" 
		yAxisTitle = "#application.rb.getResource("sessionNumbers")#" 
		show3D = "yes"
		rotated = "no" 
		showLegend = "yes" 
		tipStyle = "MouseOver">
		
		<cfchartseries type="bar" query="q1" itemcolumn="hour" valuecolumn="count_Ip" serieslabel="#application.rb.getResource("Today")#" paintstyle="shade"></cfchartseries>
		<cfchartseries type="bar" query="q2" itemcolumn="hour" valuecolumn="count_Ip" serieslabel="#application.rb.getResource("Yesterday")#" paintstyle="shade"></cfchartseries>
		<cfchartseries type="bar" query="q3" itemcolumn="hour" valuecolumn="count_Ip" serieslabel="#application.rb.getResource("DayBefore")#" paintstyle="shade"></cfchartseries>
	</cfchart>
	</cfoutput>
	
	<hr />
	
	<!--- weekly stats --->
	
	<!--- #### work out dates #### --->
	<!--- loop over weeks --->
	<cfloop from="0" to="4" index="queryWeek">
		<!--- loop over days in week --->
		<cfloop from="1" to="7" index="day">
			<!--- check if day is a sunday (ie start of weeek) --->
			<cfif dayofweek(dateadd("d",-day,dateadd("ww",-queryWeek,now()))) eq weekStartDay>
				<!--- if it is sunday, set startdate for that week --->
				<cfset "q#queryWeek#Date" = dateadd("d",-day,dateadd("ww",-queryWeek,now()))>
			</cfif>
		</cfloop>
	</cfloop>
	
	<!--- Oracle conversion not complete yet for this method --->
	<cfif NOT application.dbType is "ora">
	<cfscript>
	q1 = application.factory.oStats.getVisitorStatsByWeek(day=q0Date);
	q2 = application.factory.oStats.getVisitorStatsByWeek(day=q1Date);
	q3 = application.factory.oStats.getVisitorStatsByWeek(day=q2Date);
	q4 = application.factory.oStats.getVisitorStatsByWeek(day=q3Date);
	</cfscript>
	
	<cfoutput>

	<hr />
	
	<h3>#application.rb.getResource("sessionsPerDayLast4Weeks")#</h3>
	<div style="z-index:100">
	<cfchart 
		chartHeight="400" 
		chartWidth="600" 
		scaleFrom="0" 
		showXGridlines = "yes" 
		showYGridlines = "yes"
		seriesPlacement="default"
		showBorder = "no"
		fontsize="12"
		labelFormat = "number"
		xAxisTitle = "#application.rb.getResource("Day")#" 
		yAxisTitle = "#application.rb.getResource("sessionNumbers")#" 
		show3D = "yes"
		xOffset = "0.15" 
		yOffset = "0.15"
		rotated = "no" 
		showLegend = "yes" 
		tipStyle = "MouseOver">
	<cfchartseries type="bar" query="q1" itemcolumn="name" valuecolumn="count_Ip" serieslabel="#application.rb.getResource("thisWeek")#" paintstyle="shade"></cfchartseries>
	<cfchartseries type="bar" query="q2" itemcolumn="name" valuecolumn="count_Ip" serieslabel="#application.rb.getResource("lastWeek")#" paintstyle="shade"></cfchartseries>
	<cfchartseries type="bar" query="q3" itemcolumn="name" valuecolumn="count_Ip" serieslabel="#application.rb.getResource("twoWeeksBefore")#" paintstyle="shade"></cfchartseries>
	<cfchartseries type="bar" query="q4" itemcolumn="name" valuecolumn="count_Ip" serieslabel="#application.rb.getResource("threeWeeksBefore")#" paintstyle="shade"></cfchartseries>
	</cfchart>
	</div>
	</cfoutput>
	
	</cfif>
	
	<!--- #### graph of view per day between 2 chosen dates #### --->
	
	<!--- default values --->
	<cfparam name="form.before" default="#now()+1#">
	<cfparam name="form.after" default="#dateadd("m",-3,before)#">
	
	<!--- make sure before is actually after "after" date --->
	<cfif form.before lt form.after>
		<cfset temp = form.before>
		<cfset form.before = form.after>
		<cfset form.after = temp>
	</cfif>
	
	<cfset form.before = createODBCDate(form.before)>
	<cfset form.after = createODBCDate(form.after)> 
	
	<!--- call method --->
	<cfscript>
	q1 = application.factory.oStats.getVisitorStatsByDate(before=createodbcdate(form.before),after=createodbcdate(form.after));
	</cfscript>
	
	
	
	<cfoutput>

	<hr />

	<h3>
	<cfset subS=listToArray('#application.thisCalendar.i18nDateFormat(form.after,session.dmProfile.locale,application.fullF)#^#application.thisCalendar.i18nDateFormat(form.before,session.dmProfile.locale,application.fullF)#',"^")>

	#application.rb.formatRBString("sessionsPerDayBetween",subS)#
	</h3>
	
	<cfif q1.qGetPageStats.recordcount>
		<!--- ouput graph --->
		<cfchart 
			chartHeight="400" 
			chartWidth="600" 
			scaleFrom="0" 
			showXGridlines = "yes" 
			showYGridlines = "yes"
			seriesPlacement="default"
			showBorder = "no"
			fontsize="12"
			labelFormat = "number"
			xAxisTitle = "#application.rb.getResource("Date")#" 
			yAxisTitle = "#application.rb.getResource("sessionNumbers")#" 
			show3D = "yes"
			xOffset = "0.15" 
			yOffset = "0.15"
			rotated = "no" 
			showLegend = "yes" 
			tipStyle = "MouseOver"
			gridlines = "#q1.max+1#">
		<cfchartseries type="line" query="q1.qGetPageStats" itemcolumn="viewday" valuecolumn="count_Ip" serieslabel="#application.rb.formatRBString("sessionsPerDayBetween",subS)#" paintstyle="shade"></cfchartseries>
		</cfchart>
	<cfelse>
		<cfoutput><div style="color:red">#application.rb.getResource("noStatsBetween")#</div></cfoutput>
	</cfif>
	
	<hr />
	<cfset Request.InHead.Calendar = 1>
	<div>
	<form method="post" class="f-wrap-1 f-bg-short" action="">
	<fieldset>
	
		<h3>Edit range</h3>
		<label>
		<b>#application.rb.getResource("betweenLabel")#</b>
		<input type="text" id="afterDate" style="width:200px" name="after" value="#application.thisCalendar.i18nDateFormat(form.after,session.dmProfile.locale,application.fullF)#" />
		<input type="button" id"afterDateButton" value="select" /><br />
		</label>
		
		<label>
		<b>#application.rb.getResource("andLabel")#</b>
		<input type="text" id="beforeDate" style="width:200px" name="before" value="#application.thisCalendar.i18nDateFormat(form.before,session.dmProfile.locale,application.fullF)#" />
		<input type="button" id="beforeDateButton" value="select" /><br />
		</label>
		
		
		
		<div class="f-submit-wrap">
		<input type="submit" value="Change Date Range" class="f-submit" />
		</div>
		<div id="calendarContainer" style="width:300px; height:200px">
		
		</div>
	<fieldset>
	</form>
	</div>
	<script type="text/javascript">
					  Calendar.setup(
					    {
					    
						  inputField	: "afterDate",         // ID of the input field
					      ifFormat		: "%d/%m/%Y",    // the date format
					      button		: "afterDateButton",       // ID of the button
					      showsTime		: false,
					      align         : "bR"
					      
					    }
					  );
					  
					  Calendar.setup(
					    {
					    
						  inputField	: "beforeDate",         // ID of the input field
					      ifFormat		: "%d/%m/%Y",    // the date format
					      button		: "beforeDateButton",       // ID of the button
					      showsTime		: false,
					      align         : "bR"
					      
					    }
					  );
					  
	</script>	
	</cfoutput>
</sec:CheckPermission>

<!--- setup footer --->
<admin:footer>

<cfsetting enablecfoutputonly="yes">