<cfsetting enablecfoutputonly="true">

<!--- @@displayname: Reset password --->
<!--- @@description: Checks the client's security question and answer, then resets their password --->
<!--- @@author:  Blair McKenzie (blair@daemon.com.au) --->

<!--- @@viewBinding: type --->
<!--- @@viewStack: page --->

<cfimport taglib="/farcry/core/tags/formtools" prefix="ft" />
<cfimport taglib="/farcry/core/tags/security" prefix="sec" />
<cfimport taglib="/farcry/core/tags/webskin/" prefix="skin" />


<ft:processForm action="Retrieve User ID">
	
	<ft:processFormObjects typename="dmProfile">
		
		<cfif structKeyExists(stProperties, "emailAddress") AND len(stProperties.emailAddress)>
			<cfquery datasource="#application.dsn#" name="qProfileFromEmail">
			SELECT objectid,username 
			FROM dmProfile
			WHERE emailAddress = <cfqueryparam cfsqltype="cf_sql_varchar" value="#stProperties.emailAddress#">
			AND userDirectory = 'CLIENTUD'
			</cfquery>
			
			<cfif qProfileFromEmail.recordCount>
				<cfset stUser = createObject("component", application.stcoapi["farUser"].packagePath).getByUserID(userID="#application.factory.oUtils.listSlice(qProfileFromEmail.username,1,-2,"_")#") />
				
				<skin:view objectid="#stUser.objectid#" typename="farUser" webskin="forgotUserIDEmail" />
				
				<cfset request.emailSent = true />
			<cfelse>
				<cfset request.notFound = true />
			</cfif>

		</cfif>
		<ft:break />
	</ft:processFormObjects>
</ft:processForm>



<skin:view typename="farUser" template="displayHeaderLogin" />


<cfoutput><div class="loginInfo"></cfoutput>
	<ft:form>
	
		
		
		<cfif structKeyExists(request, "notFound")>
			<cfoutput>
				<p id="errorMsg"><admin:resource key="coapi.farUser.forgotuserid.emailnotonrecord@text">We do not have that email address on record. Please try again.</admin:resource></p>
			</cfoutput>
		</cfif>	
			
		<cfif structKeyExists(request, "emailSent")>
			<cfoutput>
				<p id="OKMsg"><admin:resource key="coapi.farUser.forgotuserid.confirmationsent@text">A confirmation email with your User ID has been sent to your email address and should arrive shortly.</admin:resource></p>
			</cfoutput>
		<cfelse>
			<cfoutput>
				<p><admin:resource key="coapi.farUser.forgotuserid.blurb@text">So you forgot your User ID. Please enter your email address below to reset. An email with your new password will be sent to your email address.</admin:resource></p>
			</cfoutput>

				<ft:object typename="dmProfile" lfields="emailAddress" />

				<ft:buttonPanel>
					<ft:button value="Retrieve User ID" rbkey="security.button.retrieveuserid" />
				</ft:buttonPanel>

		</cfif>

		
	
		<cfoutput><ul class="loginForgot"></cfoutput>
		<sec:CheckPermission webskinpermission="forgotPassword" type="farUser">
			<cfoutput>
				<li><skin:buildLink type="farUser" view="forgotPassword" rbkey="coapi.farLogin.login.forgotpassword">Forgot Password</skin:buildLink></li></cfoutput>
		</sec:CheckPermission>		
		<sec:CheckPermission webskinpermission="registerNewUser" type="farUser">
			<cfoutput>
				<li><skin:buildLink type="farUser" view="registerNewUser" rbkey="coapi.farLogin.login.registernewuser">Register New User</skin:buildLink></li></cfoutput>
		</sec:CheckPermission>			
			
		<cfoutput>
			<li><skin:buildLink href="#application.url.webtoplogin#" rbkey="coapi.farLogin.login.login">Login</skin:buildLink></li></cfoutput>
		<cfoutput></ul></cfoutput>
	
			
	</ft:form>

	
<cfoutput></div></cfoutput>


<skin:view typename="farUser" template="displayFooterLogin" />

<cfsetting enablecfoutputonly="false">