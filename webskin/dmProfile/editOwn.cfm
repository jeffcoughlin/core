<cfsetting enablecfoutputonly="true" />
<!--- @@displayname: Edit Profile --->
<!--- @@description: Form for users editing their own profile --->

<!--- import tag libraries --->
<cfimport taglib="/farcry/core/tags/formtools/" prefix="ft" />
<cfimport taglib="/farcry/core/tags/webskin/" prefix="skin" />
<cfimport taglib="/farcry/core/tags/admin" prefix="admin" />

<cfset stProfile = getData(objectid=session.dmProfile.objectid) />
<cfif structkeyexists(stObj,"bDefaultObject") and stObj.bDefaultObject>
	<cfset stObj = stProfile />
</cfif>

<!--- You can not edit other users' profiles --->	
<cfif NOT application.security.getCurrentUserID() eq stObj.username>
	<cfthrow message="Invalid Profile Change" detail="You can not edit other users' profiles." />
</cfif>

<!----------------------------- 
ACTION	
------------------------------>
<ft:processform action="Save" url="refresh">
	<ft:processformobjects objectid="#stobj.objectid#">
		<cfset structappend(session.dmProfile,stProperties,true) />

		<skin:bubble title="Profile Saved" bAutoHide="false" tags="type,dmProfile,update,info">
			<cfoutput>Your profile has been saved. You can always update your profile by using the dropdown menu by your name in the top right.</cfoutput>
		</skin:bubble>
		
		<cfset session.firstLogin = false />
	</ft:processformobjects>
</ft:processform>


<admin:header>

<!----------------------------- 
VIEW	
------------------------------>
<cfif session.firstLogin>
	<!--- todo: i18n --->
	
	<cfoutput>
		<h1>Welcome to FarCry</h1>
		<p>This seems to be the first time you've logged into the webtop. Please update your profile now.</p>
	</cfoutput>
<cfelse>
	<cfoutput>
		<h1>#application.rb.getResource('coapi.dmProfile.general.editprofile@label','Edit Your Profile')#</h1>
	</cfoutput>
</cfif>

<ft:form>
	<ft:object objectid="#stObj.objectid#" typename="dmProfile" lfields="firstname,lastname,phone,fax,emailaddress,breceiveemail,avatar" legend="Contact Details" />
	<ft:object objectid="#stObj.objectid#" typename="dmProfile" lfields="position,department" legend="Job Details" />
	<ft:object objectid="#stObj.objectid#" typename="dmProfile" lfields="locale" legend="Language Details" />
	
	<ft:buttonPanel>
		<ft:button value="Save" text="Update Profile" color="orange" />
		<ft:button value="Cancel" validation="false" />
	</ft:buttonPanel>
</ft:form>

<admin:footer>

<cfsetting enablecfoutputonly="false" />