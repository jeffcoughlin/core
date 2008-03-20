<cfsetting enablecfoutputonly="Yes">
<!--- @@Copyright: Daemon Pty Limited 1995-2007, http://www.daemon.com.au --->
<!--- @@License: Released Under the "Common Public License 1.0", http://www.opensource.org/licenses/cpl.php --->
<!--- @@displayname: Farcry UD login form --->
<!--- @@description:   --->
<!--- @@author: Matthew Bryant (mbryant@daemon.com.au) --->


<!------------------ 
FARCRY IMPORT FILES
 ------------------>
<cfimport taglib="/farcry/core/tags/formtools/" prefix="ft" />
<cfimport taglib="/farcry/core/tags/security/" prefix="sec" />
<cfimport taglib="/farcry/core/tags/webskin/" prefix="skin" />



<!------------------ 
START WEBSKIN
 ------------------>	

<skin:view typename="farLogin" template="displayHeaderLogin" />
	
			
		<cfoutput>
		<div class="loginInfo">
		</cfoutput>	
		
			<ft:form>	
				
				<sec:selectProject />
				
				<sec:SelectUDLogin />
				
	
				<ft:object typename="farLogin" lFields="username,password" legend="Login to #application.config.general.siteTitle#" />
					
				
				<ft:farcrybuttonPanel>
				
	
					<cfif isdefined("arguments.stParam.message") and len(arguments.stParam.message)>
						<cfoutput>
							<div class="error">#arguments.stParam.message#</div>
						</cfoutput>
					</cfif>
					
					<ft:farcrybutton value="Log In" />
				</ft:farcrybuttonPanel>
				
				<cfset stParameters = structNew() />
				<cfset stParameters.returnUrl = "#url.returnUrl#" />
				
				<ft:farcrybuttonPanel>					
					<cfoutput><ul class="fc"></cfoutput>
						<sec:CheckPermission webskinpermission="forgotPassword" type="farUser">
							<skin:buildLink type="farUser" view="forgotPassword" stParameters="#stParameters#"><cfoutput><li>Forgot Password</li></cfoutput></skin:buildLink>
						</sec:CheckPermission>
						<sec:CheckPermission webskinpermission="forgotUserID" type="farUser">
							<skin:buildLink type="farUser" view="forgotUserID" stParameters="#stParameters#"><cfoutput><li>Forgot UserID</li></cfoutput></skin:buildLink>
						</sec:CheckPermission>			
						<sec:CheckPermission webskinpermission="registerNewUser" type="farUser">
							<skin:buildLink type="farUser" view="registerNewUser" stParameters="#stParameters#"><cfoutput><li>Register New User</li></cfoutput></skin:buildLink>
						</sec:CheckPermission>
					<cfoutput></ul></cfoutput>
					
				</ft:farcrybuttonPanel>
			</ft:form>
			
		<cfoutput>
		</div>
		</cfoutput>		
				
	

<skin:view typename="farLogin" template="displayFooterLogin" />


<cfsetting enablecfoutputonly="false">