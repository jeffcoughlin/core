<!--- @@timeout: 0 --->
<cfparam name="ARGUMENTS.STPARAM.loginpath" default="#application.url.farcry#/login.cfm?returnUrl=#URLEncodedFormat(cgi.script_name&'?'&cgi.query_string)#" type="string">
<cfimport taglib="/farcry/core/tags/extjs" prefix="extjs" />
<extjs:bubble title="Security" message="You do not have permission to access this part of the website" />
<cflocation url="#ARGUMENTS.STPARAM.loginpath#&error=restricted" addtoken="No" />