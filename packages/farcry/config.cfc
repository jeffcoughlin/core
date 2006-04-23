<!--- 
|| LEGAL ||
$Copyright: Daemon Pty Limited 1995-2003, http://www.daemon.com.au $
$License: Released Under the "Common Public License 1.0", http://www.opensource.org/licenses/cpl.php$

|| VERSION CONTROL ||
$Header: /cvs/farcry/farcry_core/packages/farcry/config.cfc,v 1.20 2004/01/19 06:14:19 brendan Exp $
$Author: brendan $
$Date: 2004/01/19 06:14:19 $
$Name: milestone_2-1-2 $
$Revision: 1.20 $

|| DESCRIPTION || 
$Description: config cfc $
$TODO: $

|| DEVELOPER ||
$Developer: Brendan Sisson (brendan@daemon.com.au) $

|| ATTRIBUTES ||
$in: $
$out:$
--->

<cfcomponent displayname="Configuration" hint="Manages configuration files for FarCry CMS.">

<cffunction name="deployConfig" returntype="struct">
    <cfargument name="dsn" type="string" default="#application.dsn#" required="true" hint="Database DSN">
    <cfargument name="bDropTable" type="boolean" default="false" required="false">

	<cfinclude template="_config/deployConfig.cfm">
	
	<cfreturn stStatus>
</cffunction>

<cffunction name="list" returntype="query">
    <cfargument name="dsn" type="string" default="#application.dsn#" required="true" hint="Database DSN">

	<cfset var q = "">
	
	<cfquery datasource="#arguments.dsn#" name="q">
		SELECT configName FROM #application.dbowner#config
	</cfquery>

	<cfreturn q>
</cffunction>

<cffunction name="deployCustomConfig" returntype="struct" hint="Gets structure of custom config and either deploys or restores config">
    <cfargument name="dsn" type="string" default="#application.dsn#" required="true" hint="Database DSN">
   	<cfargument name="config" type="string" required="true" hint="name of custom config">
	<cfargument name="action" type="string" required="true" default="deploy" hint="Action to do, deploy or re-deploy">
	
	<!--- get config structure --->
	<cftry>
		<cfinclude template="/farcry/#application.applicationName#/system/dmConfig/#arguments.config#">
		<cfcatch><cfdump var="#cfcatch#"><cfabort></cfcatch>
	</cftry>
	
	<cfset configName = listGetAt(arguments.config,1,".")>
	<cfif arguments.action eq "deploy">
		<!--- deploy new config --->
		<cfset stStatus = createConfig(configName=configName,stConfig=stConfig)>
	<cfelse>
		<!--- redeploy existing config --->
		<cfset stStatus = setConfig(configName=configName,stConfig=stConfig)>
	</cfif>	
	
	<!--- set config structure to application scope --->
	<cfset "application.config.#configName#" = duplicate(stConfig)>
	
	<cfreturn stStatus>
</cffunction>

<cffunction name="getConfig" returntype="struct">
	<cfargument name="configName" required="Yes" type="string">
    <cfargument name="dsn" type="string" default="#application.dsn#" required="true" hint="Database DSN">
	<cfset var q = "">
		
	<cfquery datasource="#arguments.dsn#" name="q">
		SELECT wConfig FROM #application.dbowner#config
		WHERE upper(configName) = '#ucase(arguments.configName)#'
	</cfquery>
	
	<cfif q.recordcount>
		<cfwddx action="WDDX2CFML" input="#q.wConfig#" output="stConfig">
	<cfelse>
		<cfset stConfig = structNew()>
	</cfif>
	
	<cfreturn stConfig>
</cffunction>

<cffunction name="setConfig" returntype="struct">
    <cfargument name="dsn" type="string" default="#application.dsn#" required="true" hint="Database DSN">
	<cfargument name="configName" required="Yes" type="string">
	<cfargument name="stConfig" required="Yes" type="struct">
	<cfset var stStatus = StructNew()>
		
	<cfwddx action="CFML2WDDX" input="#arguments.stConfig#" output="wConfig">
	
	<cfquery datasource="#arguments.dsn#" name="qUpdate">
		UPDATE #application.dbowner#config
		SET
		wConfig = '#wConfig#'
		WHERE 
		configName = '#arguments.configName#'
	</cfquery>
	
	<cfset stStatus.msg = "#arguments.configName# updated successfully">
	<cfreturn stStatus>
</cffunction>

<cffunction name="createConfig">
    <cfargument name="dsn" type="string" default="#application.dsn#" required="true" hint="Database DSN">
	<cfargument name="configName" required="Yes" type="string">
	<cfargument name="stConfig" required="Yes" type="struct">
	<cfset var stStatus = StructNew()>
	
	<cfwddx action="CFML2WDDX" input="#arguments.stConfig#" output="wConfig">
	
	<cfquery datasource="#arguments.dsn#" name="qUpdate">
	INSERT INTO #application.dbowner#config
	(configName, wConfig)
	VALUES
	('#arguments.configName#', '#wConfig#')
	</cfquery>

	<cfset stStatus.msg = "#arguments.configName# created successfully">
	<cfreturn stStatus>
</cffunction>

<cffunction name="defaultVerity">
    <cfargument name="dsn" type="string" default="#application.dsn#" required="true" hint="Database DSN">
	<cfargument name="configName" required="No" type="string" default="verity">
	
	<cfinclude template="_config/defaultVerity.cfm">
	
	<cfreturn stStatus>
</cffunction>

<cffunction name="defaultPlugins">
    <cfargument name="dsn" type="string" default="#application.dsn#" required="true" hint="Database DSN">
	<cfargument name="configName" required="No" type="string" default="plugins">
	
	<cfinclude template="_config/defaultPlugins.cfm">
	
	<cfreturn stStatus>
</cffunction>

<cffunction name="defaultImage">
    <cfargument name="dsn" type="string" default="#application.dsn#" required="true" hint="Database DSN">
	<cfargument name="configName" required="No" type="string" default="image">
	
	<cfinclude template="_config/defaultImage.cfm">
	
	<cfreturn stStatus>
</cffunction>

<cffunction name="defaultFile">
    <cfargument name="dsn" type="string" default="#application.dsn#" required="true" hint="Database DSN">
	<cfargument name="configName" required="No" type="string" default="file">
	
	<cfinclude template="_config/defaultFile.cfm">
	
	<cfreturn stStatus>
</cffunction>

<cffunction name="defaultSoEditorPro">
    <cfargument name="dsn" type="string" default="#application.dsn#" required="true" hint="Database DSN">
	<cfargument name="configName" required="No" type="string" default="soEditorPro">
	
	<cfinclude template="_config/defaultSoEditorPro.cfm">
	
	<cfreturn stStatus>
</cffunction>

<cffunction name="defaultSoEditor">
    <cfargument name="dsn" type="string" default="#application.dsn#" required="true" hint="Database DSN">
	<cfargument name="configName" required="No" type="string" default="soEditor">
	
	<cfinclude template="_config/defaultSoEditor.cfm">
	
	<cfreturn stStatus>
</cffunction>

<cffunction name="defaultGeneral">
    <cfargument name="dsn" type="string" default="#application.dsn#" required="true" hint="Database DSN">
	<cfargument name="configName" required="No" type="string" default="general">
	
	<cfinclude template="_config/defaultGeneral.cfm">
	
	<cfreturn stStatus>
</cffunction>

<cffunction name="defaultEWebEditPro">
    <cfargument name="dsn" type="string" default="#application.dsn#" required="true" hint="Database DSN">
	<cfargument name="configName" required="No" type="string" default="eWebEditPro">
	
	<cfinclude template="_config/defaultEWebEditPro.cfm">
	
	<cfreturn stStatus>
</cffunction>


<cffunction name="defaultEOPro">
    <cfargument name="dsn" type="string" default="#application.dsn#" required="true" hint="Database DSN">
	<cfargument name="configName" required="No" type="string" default="eoPro">
	
	<cfinclude template="_config/defaultEOPro.cfm">
	
	<cfreturn stStatus>
</cffunction>


<cffunction name="defaultFU">
    <cfargument name="dsn" type="string" default="#application.dsn#" required="true" hint="Database DSN">
	<cfargument name="configName" required="No" type="string" default="FUSettings">
	
	<cfinclude template="_config/defaultFU.cfm">
	
	<cfreturn stStatus>
</cffunction>

</cfcomponent>
