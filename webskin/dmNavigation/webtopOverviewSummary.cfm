
<cfimport taglib="/farcry/core/tags/navajo" prefix="nj" />
<cfimport taglib="/farcry/core/tags/webskin" prefix="skin" />
<cfimport taglib="/farcry/core/tags/security" prefix="sec" />
<cfimport taglib="/farcry/core/tags/formtools" prefix="ft" />
<cfimport taglib="/farcry/core/tags/grid" prefix="grid" />
<cfimport taglib="/farcry/core/tags/admin" prefix="admin" />


<ft:processForm action="Manage">
	
	<!--- get parent to update tree --->
	<nj:treeGetRelations typename="#stObj.typename#" objectId="#stObj.ObjectID#" get="parents" r_lObjectIds="ParentID" bInclusive="1">
	
	<!--- update tree --->
	<nj:updateTree objectId="#parentID#">
		
	<cfif structKeyExists(form, "selectedObjectID")>
		<skin:location url="#application.url.webtop#/edittabOverview.cfm?objectid=#form.selectedObjectID#" />
	</cfif>
</ft:processForm>


<cfoutput>
<h2>CONTENT ITEM INFORMATION</h2>
ALIAS: <cfif len(stobj.lNavIDAlias)>#stobj.lNavIDAlias#<cfelse>N/A</cfif><br />
</cfoutput>



<cfif arraylen(stObj.aObjectIDs)>
	
	<cfoutput>
	<h2>ATTACHED CONTENT</h2>
	<table class="objectAdmin">
	
	<cfloop from="1" to="#arrayLen(stobj.aObjectIDs)#" index="i">
		<cfset contentTypename = application.fapi.findType(objectid="#stobj.aObjectIDs[i]#") />
		
		<tr>
			<td><skin:icon icon="#application.stCOAPI[contentTypename].icon#" size="16" default="farcrycore" /></td>	
			<td><skin:view typename="#contentTypename#" objectid="#stobj.aObjectIDs[i]#" webskin="displayLabel" /></td>	
			<td><ft:button value="Manage" renderType="link" selectedObjectID="#stobj.aObjectIDs[i]#" /></td>	
		</tr>
			
	</cfloop>	
	
	</table>
	</cfoutput>
</cfif>
	


<nj:getNavigation objectId="#stobj.objectid#" r_objectID="parentID" bInclusive="1">

<cfif application.fapi.checkObjectPermission(objectID=parentID, permission="Create")>
	<cfset objType = application.fapi.getContentType(stobj.typename) />
	<cfset lPreferredTypeSeq = "dmNavigation,dmHTML"> <!--- this list will determine preffered order of objects in create menu - maybe this should be configurable. --->
	<!--- <cfset aTypesUseInTree = objType.buildTreeCreateTypes(lPreferredTypeSeq)> --->
	<cfset lAllTypes = structKeyList(application.types)>
	<!--- remove preffered types from *all* list --->
	<cfset aPreferredTypeSeq = listToArray(lPreferredTypeSeq)>
	<cfloop index="i" from="1" to="#arrayLen(aPreferredTypeSeq)#">
		<cfset lAlltypes = listDeleteAt(lAllTypes,listFindNoCase(lAllTypes,aPreferredTypeSeq[i]))>
	</cfloop>
	<cfset lAlltypes = ListAppend(lPreferredTypeSeq,lAlltypes)>
	<cfset aTypesUseInTree = objType.buildTreeCreateTypes(lAllTypes)>
	<cfif ArrayLen(aTypesUseInTree)>
		<cfoutput>
		<select id="createContent" name="createContent" style="width:180px;margin-top:10px;">
			<option value="">-- Attach New Content --</option>
			<cfloop index="i" from="1" to="#ArrayLen(aTypesUseInTree)#">
				<option value="#aTypesUseInTree[i].typename#">Create #aTypesUseInTree[i].description#</option>
				<!--- <ft:button value="Create #aTypesUseInTree[i].description#" rbkey="coapi.#aTypesUseInTree[i].typename#.buttons.createtype" url="#application.url.farcry#/conjuror/evocation.cfm?parenttype=dmNavigation&objectId=#stobj.objectid#&typename=#aTypesUseInTree[i].typename#&ref=#url.ref#" /> --->
			</cfloop>
		</select>
		</cfoutput>	
		
		<skin:onReady>
			<cfoutput>
			$j('##createContent').change(function() {
				location = '#application.url.farcry#/conjuror/evocation.cfm?parenttype=dmNavigation&objectId=#stobj.objectid#&typename=' + $j('##createContent').val() + '&ref=#url.ref#';
			});
			</cfoutput>
		</skin:onReady>
	</cfif>
</cfif>