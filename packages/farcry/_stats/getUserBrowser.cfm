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
$Header: /cvs/farcry/core/packages/farcry/_stats/getUserBrowser.cfm,v 1.11 2005/08/09 03:54:39 geoff Exp $
$Author: geoff $
$Date: 2005/08/09 03:54:39 $
$Name: milestone_3-0-1 $
$Revision: 1.11 $

|| DESCRIPTION || 
$Description: get users browser $


|| DEVELOPER ||
$Developer: Brendan Sisson (brendan@daemon.com.au) $

|| ATTRIBUTES ||
$in: $
$out:$
--->

<cfscript>
	browserName="Unknown: ";
	Variables.user_agent = cgi.http_user_agent;
	if (Len(user_agent))
	{
		browserVersion=user_agent;
		if (FindNoCase("MSIE",user_agent) AND NOT findNoCase("opera",user_agent) )
		{ 
			browserName="MSIE";
			browserVersion=Val(RemoveChars(user_agent,1,FindNoCase("MSIE",user_agent)+4));
		}
		else if (findNoCase("opera",user_agent))
		{
			browserName = "Opera";
			browserVersion = Val(RemoveChars(user_agent,1,FindNoCase("Opera",user_agent)+5));
		}	
		else if (findNoCase("safari",user_agent))
		// Safari (Macintosh)
		{
			browsername = "Safari";
			browserVersion = DecimalFormat(Int(Val(RemoveChars(user_agent,1,FindNoCase("Safari/",user_agent)+6)))/100);
			// browserVersion = Left(DecimalFormat(browserVersion), Evaluate(Len(DecimalFormat(browserVersion))-1));
			// If you'd prefer browser version to be displayed as 1.2 instead of 1.25 (since Apple releases new builds often) Then use BOTH lines (don't remark the first one).
		}	
		else if (findNoCase("Camino/",user_agent))
		// Camino (Macintosh)
		{
			browsername = "Camino";
			browserVersion = Val(RemoveChars(user_agent,1,FindNoCase("Camino/",user_agent)+6));
		}
		else if (findNoCase("Galeon/",user_agent))
		// Galeon (Gnome browser)
		{
			browsername = "Galeon";
			browserVersion = Val(RemoveChars(user_agent,1,FindNoCase("Galeon/",user_agent)+6));
			//browserVersion = ListGetAt(RemoveChars(user_agent,1,FindNoCase("Galeon/",user_agent)+6),1," ");
			// If you'd prefer browser version to be displayed as 1.3.11a instead of 1.3, then use the above line instead.
		}
		else if (findNoCase("Googlebot",user_agent))
		{
			browsername = "Googlebot";
			browserVersion = Val(RemoveChars(user_agent,1,FindNoCase("Googlebot",user_agent)+9));
		}	
		else if (findNoCase("ia_archiver",user_agent))
		{
			browsername = "ia archiver";
			browserVersion = "";// Not sure about how to disect the user_agent string for version just yet.
		}
		else	
		{
			if (FindNoCase("Mozilla/",user_agent)) { 
				if (Int(Val(RemoveChars(user_agent,1,FindNoCase("Mozilla/",user_agent)+7))) LTE 4) {
					// Netscape Navigator Browsers (v1.x - 4.x)
					browserName = "Netscape";
					browserVersion = DecimalFormat(Val(RemoveChars(user_agent,1,FindNoCase("Mozilla/",user_agent)+7)));
				}
				else if (FindNoCase("Netscape6/",user_agent)) {
					// Netscape 6 browsers
					browserName = "Netscape";
					browserVersion = DecimalFormat(Val(RemoveChars(user_agent,1,FindNoCase("Netscape6/",user_agent)+9)));
				}
				else if (FindNoCase("Netscape/",user_agent)) {
					// All other (newer) Netscape Browsers
					browserName = "Netscape";
					browserVersion = DecimalFormat(Val(RemoveChars(user_agent,1,FindNoCase("Netscape/",user_agent)+8)));
				}
				else if (not FindNoCase("compatible",user_agent)) { 
					browserVersion=Val(RemoveChars(user_agent,1,Find("/",user_agent)));
					if (browserVersion lt 5) {
						//netscape browsers
						browserName="Netscape";	
					}
					else 
					{
						if (FindNoCase("Firefox/",user_agent)) {
							// Firefox Browsers (by Mozilla)
							browserName = "Firefox";
							//browserVersion = Val(RemoveChars(user_agent,1,FindNoCase("Firefox/",user_agent)+7));
							browserVersion = ListGetAt(RemoveChars(user_agent,1,FindNoCase("Firefox/",user_agent)+7),1," ");
						} else if (FindNoCase("Firebird/",user_agent)) {
							// Firebird Browsers (now replaced by FireFox)
							browserName = "Firebird";
							browserVersion = Val(RemoveChars(user_agent,1,FindNoCase("Firebird/",user_agent)+8));
						} else {
							//mozilla browsers
							browserName = "Mozilla";
							browserVersion = Val(RemoveChars(user_agent,1,FindNoCase("rv:",user_agent)+2));
						}
					}
				}
				else
				{
					browserName="compatible"; 
				}
			}
			if (Find("ColdFusion",user_agent)) 
			{ 
				browserName="ColdFusion";
			}
		}
	} else {
		browserVersion = "unknown";
	}	
	stBroswer = structNew();
	stBrowser.name = trim(browsername);
	stBrowser.version = trim(browserversion);
</cfscript>

