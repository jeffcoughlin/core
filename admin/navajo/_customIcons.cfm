<!--- 
|| LEGAL ||
$Copyright: Daemon Pty Limited 1995-2003, http://www.daemon.com.au $
$License: Released Under the "Common Public License 1.0", http://www.opensource.org/licenses/cpl.php$ 

|| VERSION CONTROL ||
$Header: /cvs/farcry/farcry_core/admin/navajo/_customIcons.cfm,v 1.11 2003/12/15 07:43:15 paul Exp $
$Author: paul $
$Date: 2003/12/15 07:43:15 $
$Name: milestone_2-1-2 $
$Revision: 1.11 $

|| DESCRIPTION || 
$Description: Sets icons to images$
$TODO: $

|| DEVELOPER ||
$Developer: Paul Harrison (harrisonp@cbs.curtin.edu.au)$

|| ATTRIBUTES ||
$in: $
$out:$
--->

<cfsetting enablecfoutputonly="Yes">

<cfscript>
nimages = "#application.url.farcry#/images/treeImages";
cimages = "#nimages#/customIcons";
customIcons = StructNew();

customIcons.Type = StructNew();

customIcons.Type = StructNew();
customIcons.Type.default = StructNew();
customIcons.Type.default.draft ="#cimages#/defaultObjectDraft.gif";
customIcons.Type.default.pending ="#cimages#/defaultObjectPending.gif";
customIcons.Type.default.approved ="#cimages#/defaultObjectApproved.gif";
customIcons.Type.default.livedraft ="#cimages#/defaultObjectLiveDraft.gif";
customIcons.Type.default.livependingdraft ="#cimages#/defaultObjectLivePendingDraft.gif";

customIcons.Type.imageRoot = StructNew();
customIcons.Type.imageRoot.draft = "#cimages#/images.gif";
customIcons.Type.imageRoot.pending = "#cimages#/images.gif";
customIcons.Type.imageRoot.approved = "#cimages#/images.gif";

customIcons.Type.home = StructNew();
customIcons.Type.home.draft = "#cimages#/home.gif";
customIcons.Type.home.pending = "#cimages#/home.gif";
customIcons.Type.home.approved = "#cimages#/home.gif";

customIcons.Type.Rubbish = StructNew();
customIcons.Type.Rubbish.draft = "#cimages#/rubbish.gif";
customIcons.Type.Rubbish.pending = "#cimages#/rubbish.gif";
customIcons.Type.Rubbish.approved = "#cimages#/rubbish.gif";

customIcons.Type.root = StructNew();
customIcons.Type.root.draft = "#cimages#/webserver.gif";
customIcons.Type.root.pending = "#cimages#/webserver.gif";
customIcons.Type.root.approved = "#cimages#/webserver.gif";

customIcons.Type.FileRoot = StructNew();
customIcons.Type.FileRoot.draft = "#cimages#/floppyDisk.gif";
customIcons.Type.FileRoot.pending = "#cimages#/floppyDisk.gif";
customIcons.Type.FileRoot.approved = "#cimages#/floppyDisk.gif";

if( StructKeyExists( application.types, "dmNavigation" ) )
{
	customIcons.Type.dmnavigation = StructNew();
	customIcons.Type.dmnavigation.draft ="#cimages#/NavDraft.gif";
	customIcons.Type.dmnavigation.pending ="#cimages#/NavDraft.gif";
	customIcons.Type.dmnavigation.approved ="#cimages#/NavApproved.gif";
}

if( StructKeyExists( application.types, "dmImage" ) )
{
	customIcons.Type.dmImage = StructNew();
	customIcons.Type.dmImage.draft ="#cimages#/pictureDraft.gif";
	customIcons.Type.dmImage.pending ="#cimages#/picturePending.gif";
	customIcons.Type.dmImage.approved ="#cimages#/pictureApproved.gif";
}

if( StructKeyExists( application.types, "dmInclude" ) )
{
	customIcons.Type.dmInclude = StructNew();
	customIcons.Type.dmInclude.draft ="#cimages#/includeDraft.gif";
	customIcons.Type.dmInclude.pending ="#cimages#/includePending.gif";
	customIcons.Type.dmInclude.approved ="#cimages#/includeApproved.gif";
}

if( StructKeyExists( application.types, "dmFile" ) )
{
	customIcons.Type.dmFile = StructNew();
	customIcons.Type.dmFile.draft ="#cimages#/fileDraft.gif";
	customIcons.Type.dmFile.pending ="#cimages#/filePending.gif";
	customIcons.Type.dmFile.approved ="#cimages#/fileApproved.gif";
}

if( StructKeyExists( application.types, "dmCSS" ) )
{
	customIcons.Type.dmCSS = StructNew();
	customIcons.Type.dmCSS.draft ="#cimages#/cssDraft.gif";
	customIcons.Type.dmCSS.pending ="#cimages#/cssDraft.gif";
	customIcons.Type.dmCSS.approved ="#cimages#/cssDraft.gif";
}

if( StructKeyExists( application.types, "dmFlash" ) )
{
	customIcons.Type.dmFlash = StructNew();
	customIcons.Type.dmFlash.draft ="#cimages#/flashApproved.gif";
	customIcons.Type.dmFlash.pending ="#cimages#/flashApproved.gif";
	customIcons.Type.dmFlash.approved ="#cimages#/flashApproved.gif";
}

if( StructKeyExists( application.types, "dmLink" ) )
{
	customIcons.Type.dmLink = StructNew();
	customIcons.Type.dmLink.draft ="#cimages#/linkDraft.gif";
	customIcons.Type.dmLink.pending ="#cimages#/linkPending.gif";
	customIcons.Type.dmLink.approved ="#cimages#/linkApproved.gif";
}

customIcons.locked = "#cimages#/padlock.gif";
</cfscript>

<cftry>
	<cfinclude template="/farcry/#application.applicationname#/system/overviewTree/_customIcons.cfm">
	<cfcatch>
		<!--- Do Nothing --->
	</cfcatch>
</cftry>


<cfsetting enablecfoutputonly="No">
