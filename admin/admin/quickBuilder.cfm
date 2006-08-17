<!--- 
|| LEGAL ||
$Copyright: Daemon Pty Limited 1995-2003, http://www.daemon.com.au $
$License: Released Under the "Common Public License 1.0", http://www.opensource.org/licenses/cpl.php$ 

|| VERSION CONTROL ||
$Header: /cvs/farcry/farcry_core/admin/admin/quickBuilder.cfm,v 1.9 2005/09/06 00:51:07 gstewart Exp $
$Author: gstewart $
$Date: 2005/09/06 00:51:07 $
$Name: milestone_3-0-1 $
$Revision: 1.9 $

|| DESCRIPTION || 
$Description: Quickly builds a navigation structure$
$TODO:$

|| DEVELOPER ||
$Developer: Quentin Zervaas (quentin@mitousa.com) $

|| ATTRIBUTES ||
$in: $
$out:$
--->

<cfsetting enablecfoutputonly="yes">

<cfprocessingDirective pageencoding="utf-8">

<cfimport taglib="/farcry/farcry_core/tags/admin/" prefix="admin">
<cfimport taglib="/farcry/farcry_core/tags/farcry/" prefix="farcry">
<cfimport taglib="/farcry/farcry_core/tags/navajo/" prefix="nj">

<!--- character to indicate levels --->
<cfset levelToken = "-" />

<admin:header writingDir="#session.writingDir#" userLanguage="#session.userLanguage#">

<!--- check permissions --->
<cfscript>
	iDeveloperPermission = request.dmSec.oAuthorisation.checkPermission(reference="policyGroup",permissionName="developer");
</cfscript>

<cfif iDeveloperPermission eq 1>

	<cfif isDefined("form.submit")>
	    <cfscript>
	        startPoint = form.startPoint;
	        makeHtml = isDefined("form.makeHtml") and form.makeHtml;
	        if (makeHtml)
	            displayMethod = form.displayMethod;
	        makenavaliases = isDefined("form.makenavaliases") and form.makenavaliases;
	        if (makenavaliases)
	            navaliaseslevel = form.navaliaseslevel;
	
	        createdBy = session.dmSec.authentication.userlogin;
	        status = form.status;
	
	        structure = form.structure;
	
	        lines = listToArray(structure, "#chr(13)##chr(10)#");
	
	        // setup items with their level and objectids
	        items = arrayNew(1);
	        lastlevel = 1;
	
	        for (i = 1; i lte arraylen(lines); i = i + 1) {
	            prefix = spanIncluding(lines[i], levelToken);
	            prefixLen = len(prefix);
	
	            line = lines[i];
	            lineLen = len(line);
	
	            level = prefixLen + 1;
	            if (level gt lastlevel)
	                level = lastlevel + 1;
	            title = trim(right(lines[i], lineLen - prefixLen));
	
	            if (len(title) gt 0) {
	                item = structNew();
	                //item.title = ReplaceNoCase(title, "'", "''", "ALL");
	                item.title = title;
	                item.level = level;
	                item.objectid = createuuid();
	                item.parentid = '';
	                arrayAppend(items, item);
	                lastlevel = item.level;
	            }
	        }
	
	        parentstack = arrayNew(1);
	        navstack = arrayNew(1);
	        arrayAppend(parentstack, startPoint);
	
	        // now figure out each item's parent node
	        lastlevel = 0;
	        for (i = 1; i lte arraylen(items); i = i + 1) {
	            if (items[i].level lt lastlevel) {
	                diff = lastlevel - items[i].level;
	                for (j = 0; j lte diff; j = j + 1) {
	                    arrayDeleteAt(parentstack, arraylen(parentstack));
	                    arrayDeleteAt(navstack, arraylen(navstack));
	                }
	            }
	            else if (items[i].level eq lastlevel) {
	                arrayDeleteAt(parentstack, arraylen(parentstack));
	                arrayDeleteAt(navstack, arraylen(navstack));
	            }
	
	            items[i].parentid = parentstack[arraylen(parentstack)];
	
	            arrayAppend(parentstack, items[i].objectid);
	
	            navtitle = lcase(rereplacenocase(items[i].title, "\W+", "_", "all"));
	            arrayAppend(navstack, rereplace(navtitle, "_+", "_", "all"));
	
	            if (makenavaliases) {
	                if (navaliaseslevel eq 0 or items[i].level lte navaliaseslevel)
	                    items[i].lNavIDAlias = arrayToList(navstack, '_');
	                else
	                    items[i].lNavIDAlias = '';
	
	            }
	            else
	                items[i].lNavIDAlias = '';
	
	            lastlevel = items[i].level;
	        }
	
	        htmlItems = arrayNew(1);
	
	        // now finish setting up the structure of each item
	        for (i = 1; i lte arraylen(items); i = i + 1) {
	            items[i].status = status;
	            items[i].ExternalLink = '';
	            items[i].target = '';
	            items[i].options = '';
	            items[i].label = items[i].title;
	            items[i].createdby = createdBy;
	            items[i].datetimecreated = now();
	            items[i].datetimelastupdated = now();
	            items[i].lastupdatedby = createdBy;
	
	            if (makeHtml) {
	                htmlItem = structNew();
	                htmlItem.aObjectIDs = arrayNew(1);
	                htmlItem.aRelatedIDs = arrayNew(1);
	                htmlItem.aTeaserImageIDs = arrayNew(1);
	                htmlItem.body = "";
	                htmlItem.commentLog = "";
	                htmlItem.createdBy = createdBy;
	                htmlItem.datetimecreated = now();
	                htmlItem.datetimelastupdated = now();
	                htmlItem.displayMethod = displayMethod;
	                htmlItem.title = items[i].title;
	                htmlItem.label = htmlItem.title;
	                htmlItem.lastUpdatedBy = createdBy;
	                htmlItem.metaKeywords = "";
	                htmlItem.objectID = createUUID();
	                htmlItem.status = status;
	                htmlItem.teaser = "";
	                htmlItem.typeName = "dmHTML";
	                htmlItem.versionID = "";
	                htmlItem.extendedMetaData = "";
	
	                arrayAppend(htmlItems, htmlItem);
	
	                items[i].aObjectIDs = arrayNew(1);
	                items[i].aObjectIDs[1] = htmlItem.objectID;
	            }
	
	            structDelete(items[i], "level");
	        }
	    </cfscript>
	
		
	    <cfimport taglib="/farcry/fourq/tags/" prefix="q4">
	
	    <cfloop index="i" from="1" to="#arrayLen(htmlItems)#">
	        <q4:contentobjectcreate typename="#application.types[htmlItems[i].typeName].typePath#" stProperties="#htmlItems[i]#" bAudit="false">
		</cfloop>
	
	    <cfscript>
	        o_dmNav = createObject("component", application.types.dmNavigation.typePath);
	        o_farcrytree = createObject("component", "#application.packagepath#.farcry.tree");
	
	        for (i = 1; i lte arraylen(items); i = i + 1) {
	            o_dmNav.createData(dsn=application.dsn,stProperties=items[i],bAudit=false);
	            o_farCryTree.setYoungest(dsn=application.dsn,parentID=items[i].parentID,objectID=items[i].objectID,objectName=items[i].title,typeName='dmNavigation');
	        }
	    </cfscript>
	
	    <cfoutput>
	        <div class="formTitle">#application.adminBundle[session.dmProfile.locale].navTreeQuickBuilder#</div>
	        <p>
	            #application.adminBundle[session.dmProfile.locale].followingItemsCreated#
	        </p>
	        <ul>
				<cfset subS=listToArray('#arrayLen(items)#,"dmNavigation"')>
				<li>#application.rb.formatRBString(application.adminBundle[session.dmProfile.locale].objects,subS)#</li>
				<cfset subS=listToArray('#arrayLen(htmlItems)#,"dmHTML"')>
	          	<li>#application.rb.formatRBString(application.adminBundle[session.dmProfile.locale].objects,subS)#</li>
	        </ul>
	    </cfoutput>
	<cfelse>
	
	    <cfscript>
	        o = createObject("component", "#application.packagepath#.farcry.tree");
	        qNodes = o.getDescendants(dsn=application.dsn, objectid=application.navid.root);
	    </cfscript>
	
	    <nj:listTemplates typename="dmHTML" prefix="displayPage" r_qMethods="qDisplayTypes">
	
	<cfoutput>
	<script language="JavaScript">
	    function updateDisplayBox()
	    {
	        document.theForm.displayMethod.disabled = !document.theForm.makehtml.checked;
	    }
	
	    function updateNavTreeDepthBox()
	    {
	        document.theForm.navaliaseslevel.disabled = !document.theForm.makenavaliases.checked;
	    }
	</script>
	
	<form method="post" class="f-wrap-1 f-bg-long wider" action="" name="theForm">
	<fieldset>
	
		<h3>#application.adminBundle[session.dmProfile.locale].navTreeQuickBuilder#</h3>

		<label for="startPoint"><b>#application.adminBundle[session.dmProfile.locale].createStructureWithin#</b>
		<select name="startPoint" id="startPoint">
		<option value="#application.navid.root#">#application.adminBundle[session.dmProfile.locale].Root#</option>
		<cfloop query="qNodes">
		<option value="#qNodes.objectId#" <cfif qNodes.objectId eq application.navid.home>selected</cfif>>#RepeatString("&nbsp;&nbsp;|", qNodes.nlevel)#- #qNodes.objectName#</option>
		</cfloop>
		</select><br />
		</label>
		
		<label for="status"><b>#application.adminBundle[session.dmProfile.locale].status#</b>
		<select name="status" id="status">
		<option value="draft">#application.adminBundle[session.dmProfile.locale].draft#</option>
		<option value="approved">#application.adminBundle[session.dmProfile.locale].approved#</option>	            
		</select><br />
		</label>
		
		<fieldset class="f-checkbox-wrap">
		
			<b>#application.adminBundle[session.dmProfile.locale].dmHTMLItems#</b>
			
			<fieldset>
			
			<label for="makehtml">
			<input type="checkbox" name="makehtml" id="makehtml" checked="checked" value="1" class="f-checkbox" onclick="updateDisplayBox()" />
			#application.adminBundle[session.dmProfile.locale].createdmHtmlItems#
			</label>
			<select name="displayMethod" id="displayMethod">
			<cfloop query="qDisplayTypes">
			<option value="#qDisplayTypes.methodName#" <cfif qDisplayTypes.methodName eq "displayPageStandard">selected="selected"</cfif>>#qDisplayTypes.displayName#</option>
			</cfloop>
			</select> 
			<script>updateDisplayBox()</script><br />
			#application.adminBundle[session.dmProfile.locale].displayMethod#
			
			</fieldset>
		
		</fieldset>
		
		<fieldset class="f-checkbox-wrap">
		
			<b>#application.adminBundle[session.dmProfile.locale].navAliases#</b>
			
			<fieldset>
			
			<label for="makenavaliases">
			<input type="checkbox" name="makenavaliases" id="makenavaliases" checked="checked" value="1" onclick="updateNavTreeDepthBox()" class="f-checkbox" />
			#application.adminBundle[session.dmProfile.locale].createNavAliases#
			</label>
			
			<select name="navaliaseslevel">
	            <option value="0">#application.adminBundle[session.dmProfile.locale].all#</option>
	            <option value="1" selected >1</option>
	            <option value="2">2</option>
	            <option value="3">3</option>
	            <option value="4">4</option>
	            <option value="5">5</option>
	            <option value="6">6</option>
	          </select><br />
	          #application.adminBundle[session.dmProfile.locale].levels#
			  <script>updateNavTreeDepthBox()</script>
			
			</fieldset>
		
		</fieldset>
		
		<label for="levelToken"><b>#application.adminBundle[session.dmProfile.locale].levelToken#</b>
		<select name="levelToken" id="levelToken">
		<option>#levelToken#</option>
		</select><br />
		</label>
		
		<label for="structure"><b>#application.adminBundle[session.dmProfile.locale].structure#</b>
		<textarea name="structure" id="structure" rows="10" cols="40" class="f-comments"></textarea><br />
		</label>

		<div class="f-submit-wrap">
		<input type="submit" value="#application.adminBundle[session.dmProfile.locale].buildSiteStructure#" name="submit" class="f-submit" /><br />
		</div>
		

	</fieldset>
	</form>
	
	<hr />
	
	<h4>#application.adminBundle[session.dmProfile.locale].instructions#</h4>
	<p>
	#application.adminBundle[session.dmProfile.locale].quicklyBuildFarCrySiteBlurb#
	</p>
	<hr />
	
	<h4>#application.adminBundle[session.dmProfile.locale].example#</h4>
	
	<p>
	<pre>
	Item 1
	-Item 1.2
	--Item 1.2.1
	-Item 1.3
	Item 2
	-Item 2.1
	--Item 2.2
	Item 3
	</pre>
	</p>
	
	<p>
	#application.adminBundle[session.dmProfile.locale].visualPurposesBlurb#
	</p>
	
	<p>
	<pre>
	Item 1
	- Item 1.2
	-- Item 1.2.1
	</pre>
	</p>
	
	</cfoutput>
	</cfif>

<cfelse>
	<admin:permissionError>
</cfif>

<admin:footer>

<cfsetting enablecfoutputonly="no">
