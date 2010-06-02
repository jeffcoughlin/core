<!--- @@description:
Update Image Config<br />
Adds the SourceImage, StandardImage and ThumbnailImage entry to dmImage table<br />
Create SourceImages, thumbnailImages and StandardImages directories<br />
Update SourceImage, StandardImage and ThumbnailImage initial values<br />
Copy Files from Old Locations to New Locations
Add Typename Field to each array table.
Populate each new typename field.

--->
<cfoutput>
<html>
<head>
<title>Farcry Core 4.0.0 Update - #application.applicationname#</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="#application.url.farcry#/css/admin.css" rel="stylesheet" type="text/css">
</head>

<body style="margin-left:20px;margin-top:20px;">
</cfoutput>

<cfif isdefined("form.submit")>




	<!--- Adding the SourceImage, StandardImage and ThumbnailImage entry to dmImage table --->
	<cfset error = 0>
	<cfoutput><p><span class="frameMenuBullet">&raquo;</span> Adding the typename field to refCategories table...</cfoutput><cfflush>
	<cftry>
		<cfswitch expression="#application.dbtype#">
			<cfcase value="ora">
				<cfquery name="update" datasource="#application.dsn#">
					ALTER TABLE #application.dbowner#refCategories ADD typename VARCHAR2(255) NULL
				</cfquery>
			</cfcase>
			<cfcase value="mysql,mysql5">
				<cfquery name="update" datasource="#application.dsn#">
					ALTER TABLE #application.dbowner#refCategories ADD typename VARCHAR(255) NULL
				</cfquery>
			</cfcase>
			<cfcase value="postgresql">
				
				<cfquery name="update" datasource="#application.dsn#">
					ALTER TABLE #application.dbowner#refCategories ADD typename VARCHAR(255) NULL
				</cfquery>
			</cfcase>
			<cfdefaultcase>
				<cfquery name="update" datasource="#application.dsn#">
					ALTER TABLE #application.dbowner#refCategories ADD typename VARCHAR(255) NULL
				</cfquery>
			</cfdefaultcase>
		</cfswitch>

		<cfcatch><cfset error=1><cfoutput><strong>field already exist.</strong></p></cfoutput></cfcatch>
	</cftry>

	<cfif not error>
		<cfoutput><strong>done</strong></p></cfoutput><cfflush>
	</cfif>
	
	

	<!--- Update Image Config --->
	<cfset error = 0>
	<cfoutput><p><span class="frameMenuBullet">&raquo;</span> Updating image config properties...</cfoutput><cfflush>
	<cfquery name="qList" datasource="#application.dsn#">
	SELECT	wconfig
	FROM	#application.dbowner#config
	WHERE	configname = 'image'
	</cfquery>

	<cfwddx action="wddx2cfml" input="#qList.wconfig#" output="stConfig">
	
	<cfparam name="stConfig.SourceImagePath" default="#application.path.project#/www/images/Source" />
	<cfparam name="stConfig.SourceImageURL" default="/images/Source" />
	<cfparam name="stConfig.ThumbnailImagePath" default="#application.path.project#/www/images/Thumbnail" />
	<cfparam name="stConfig.ThumbnailImageURL" default="/images/Thumbnail" />
	<cfparam name="stConfig.ThumbnailImageWidth" default="80" />
	<cfparam name="stConfig.ThumbnailImageHeight" default="80" />
	
	<cfparam name="stConfig.StandardImagePath" default="#application.path.project#/www/images/Standard" />
	<cfparam name="stConfig.StandardImageURL" default="/images/Standard" />
	<cfparam name="stConfig.StandardImageWidth" default="400" />
	<cfparam name="stConfig.StandardImageHeight" default="400" />

	
	<cfwddx action="CFML2WDDX" input="#stConfig#" output="wConfig">
	<cfquery name="qUpdate" datasource="#application.dsn#">
	UPDATE	#application.dbowner#config
	SET		wconfig = '#wConfig#'
	WHERE	configname = 'image'
	</cfquery>
	<cfif not error>
		<cfoutput><strong>done</strong></p></cfoutput><cfflush>
	</cfif>
	
	
	<!--- Adding the SourceImage, StandardImage and ThumbnailImage entry to dmImage table --->
	<cfset error = 0>
	<cfoutput><p><span class="frameMenuBullet">&raquo;</span> Adding the SourceImage, StandardImage and ThumbnailImage entry to dmImage table...</cfoutput><cfflush>
	<cftry>
		<cfswitch expression="#application.dbtype#">
			<cfcase value="ora">
				<cfquery name="update" datasource="#application.dsn#">
					ALTER TABLE #application.dbowner#dmImage ADD SourceImage VARCHAR2(255) NULL
				</cfquery>
				<cfquery name="update" datasource="#application.dsn#">
					ALTER TABLE #application.dbowner#dmImage ADD StandardImage VARCHAR2(255) NULL
				</cfquery>
				<cfquery name="update" datasource="#application.dsn#">
					ALTER TABLE #application.dbowner#dmImage ADD ThumbnailImage VARCHAR2(255) NULL
				</cfquery>
			</cfcase>
			<cfcase value="mysql,mysql5">
				<cfquery name="update" datasource="#application.dsn#">
					ALTER TABLE #application.dbowner#dmImage ADD SourceImage VARCHAR(255) NULL
				</cfquery>
				<cfquery name="update" datasource="#application.dsn#">
					ALTER TABLE #application.dbowner#dmImage ADD StandardImage VARCHAR(255) NULL
				</cfquery>
				<cfquery name="update" datasource="#application.dsn#">
					ALTER TABLE #application.dbowner#dmImage ADD ThumbnailImage VARCHAR(255) NULL
				</cfquery>
			</cfcase>
			<cfcase value="postgresql">
				
				<cfquery name="update" datasource="#application.dsn#">
					ALTER TABLE #application.dbowner#dmImage ADD SourceImage VARCHAR(255) NULL
				</cfquery>
				<cfquery name="update" datasource="#application.dsn#">
					ALTER TABLE #application.dbowner#dmImage ADD StandardImage VARCHAR(255) NULL
				</cfquery>
				<cfquery name="update" datasource="#application.dsn#">
					ALTER TABLE #application.dbowner#dmImage ADD ThumbnailImage VARCHAR(255) NULL
				</cfquery>
			</cfcase>
			<cfdefaultcase>
				<cfquery name="update" datasource="#application.dsn#">
					ALTER TABLE #application.dbowner#dmImage ADD SourceImage VARCHAR(255) NULL
				</cfquery>
				<cfquery name="update" datasource="#application.dsn#">
					ALTER TABLE #application.dbowner#dmImage ADD StandardImage VARCHAR(255) NULL
				</cfquery>
				<cfquery name="update" datasource="#application.dsn#">
					ALTER TABLE #application.dbowner#dmImage ADD ThumbnailImage VARCHAR(255) NULL
				</cfquery>
			</cfdefaultcase>
		</cfswitch>

		<cfcatch><cfset error=1><cfoutput><strong>fields already exist.</strong></p></cfoutput></cfcatch>
	</cftry>

	<cfif not error>
		<cfoutput><strong>done</strong></p></cfoutput><cfflush>
	</cfif>
	

	<!--- Create SourceImages, thumbnailImages and StandardImages directories  --->
	<cfset error = 0>
	<cfoutput><p><span class="frameMenuBullet">&raquo;</span> Create SourceImages, thumbnailImages and StandardImages directories...</cfoutput><cfflush>
	<cftry>
	
		<cfif NOT directoryExists("#application.path.project#\www\images\Source\")>
			<cfdirectory action="create" directory="#application.path.project#\www\images\Source\">
		</cfif>
		<cfif NOT directoryExists("#application.path.project#\www\images\thumbnail\")>
			<cfdirectory action="create" directory="#application.path.project#\www\images\thumbnail\">
		</cfif>
		<cfif NOT directoryExists("#application.path.project#\www\images\Standard\")>
			<cfdirectory action="create" directory="#application.path.project#\www\images\Standard\">
		</cfif>
		
		
		<cfcatch><cfset error=1><cfoutput><br /><span class="frameMenuBullet">&raquo;</span> <span class="error">#cfcatch.detail#</span></cfoutput></cfcatch>
	</cftry>
	<cfif not error>
		<cfoutput><strong>done</strong></p></cfoutput><cfflush>
	</cfif>


	<!--- Updating SourceImage, StandardImage and ThumbnailImage initial values --->
	<cfset error = 0>
	<cfoutput><p><span class="frameMenuBullet">&raquo;</span> Updating SourceImage, StandardImage and ThumbnailImage initial values...</cfoutput><cfflush>
	<cftry>
	
			
	
		<cfquery datasource="#application.dsn#" name="qImages">
		SELECT * FROM dmImage
		</cfquery>
		
					
		<cfoutput query="qImages">
			
			<cfif not len(qImages.ThumbnailImage) and len(qImages.Thumbnail)>
				<cfset NewImageName = qImages.Thumbnail>
				<cfif len(qImages.ThumbnailImagePath)>
					<!--- Strip the path from the Image Name if required --->
					<cfset NewImageName = ReplaceNoCase(NewImageName, qImages.ThumbnailImagePath, "" , "ALL")>
				</cfif>
				<!--- Strip //'s if any' --->
				<cfset NewImageName = ReplaceNoCase('/images/Thumbnail/#NewImageName#','//','/','ALL')>
				
				<cfquery name="qUpdate" datasource="#application.dsn#">
				UPDATE	#application.dbowner#dmImage
				SET		ThumbnailImage = '#NewImageName#'
				WHERE	objectid = '#qImages.objectid#'
				</cfquery>	
			
			</cfif> 
			
			<cfif not len(qImages.StandardImage) and len(qImages.OptimisedImage)>
				<cfset NewImageName = qImages.OptimisedImage>
				<cfif len(qImages.OptimisedImagePath)>
					<!--- Strip the path from the Image Name if required --->
					<cfset NewImageName = ReplaceNoCase(NewImageName, qImages.OptimisedImagePath, "" , "ALL")>
				</cfif>
				<!--- Strip //'s if any' --->
				<cfset NewImageName = ReplaceNoCase('/images/Standard/#NewImageName#','//','/','ALL')>

				<cfquery name="qUpdate" datasource="#application.dsn#">
				UPDATE	#application.dbowner#dmImage
				SET		StandardImage = '#NewImageName#'
				WHERE	objectid = '#qImages.objectid#'
				</cfquery>	
			</cfif>
			
			<cfif not len(qImages.SourceImage) and len(qImages.ImageFile)>
				<cfset NewImageName = qImages.ImageFile>
				<cfif len(qImages.OriginalImagePath)>
					<!--- Strip the path from the Image Name if required --->
					<cfset NewImageName = ReplaceNoCase(NewImageName, qImages.OriginalImagePath, "" , "ALL")>
				</cfif>
				<!--- Strip //'s if any' --->
				<cfset NewImageName = ReplaceNoCase('/images/Source/#NewImageName#','//','/','ALL')>

				<cfquery name="qUpdate" datasource="#application.dsn#">
				UPDATE	#application.dbowner#dmImage
				SET		SourceImage = '#NewImageName#'
				WHERE	objectid = '#qImages.objectid#'
				</cfquery>	
			</cfif>
		</cfoutput>
		
		
		<cfcatch><cfset error=1><cfoutput><br /><span class="frameMenuBullet">&raquo;</span><cfdump var="#cfcatch#"> <span class="error">#cfcatch.detail#</span></cfoutput></cfcatch>
	</cftry>
	<cfif not error>
		<cfoutput><strong>done</strong></p></cfoutput><cfflush>
	</cfif>
	

	<!--- Copy Files from Old Locations to New Locations --->
	<cfset error = 0>
	<cfoutput><p><span class="frameMenuBullet">&raquo;</span> Copying Files from Old Locations to New Locations...</cfoutput><cfflush>
	<cftry>
	
		<cfquery datasource="#application.dsn#" name="qImages">
		SELECT * FROM dmImage
		</cfquery>
		
		<cfoutput query="qImages">
			
				
			<cfif fileExists("#qImages.ThumbnailImagePath#\#qImages.Thumbnail#")
					AND NOT fileExists("#application.path.project#\www\images\thumbnail\#qImages.Thumbnail#") >
				<cffile action="copy" source="#qImages.ThumbnailImagePath#\#qImages.Thumbnail#"
						destination="#application.path.project#\www\images\thumbnail\">
			</cfif>
		
			<cfif fileExists("#qImages.ThumbnailImagePath#\#qImages.OptimisedImage#")
					AND NOT fileExists("#application.path.project#\www\images\Standard\#qImages.OptimisedImage#") >
				<cffile action="copy" source="#qImages.ThumbnailImagePath#\#qImages.OptimisedImage#"
						destination="#application.path.project#\www\images\Standard\">
			</cfif>
		
			<cfif fileExists("#qImages.OriginalImagePath#\#qImages.ImageFile#")
					AND NOT fileExists("#application.path.project#\www\images\Source\#qImages.ImageFile#") >
				<cffile action="copy" source="#qImages.OriginalImagePath#\#qImages.ImageFile#"
						destination="#application.path.project#\www\images\Source\">
			</cfif>
		</cfoutput>
		
		
		<cfcatch><cfset error=1><cfoutput><br /><span class="frameMenuBullet">&raquo;</span> <span class="error">#cfcatch.detail#</span></cfoutput></cfcatch>
	</cftry>
	<cfif not error>
		<cfoutput><strong>done</strong></p></cfoutput><cfflush>
	</cfif>	






	<!--- Add typename and rename objectid to parentid to all array tables --->
	<cfset error = 0>
	<cfoutput><p><span class="frameMenuBullet">&raquo;</span> Adding typename field and renaming objectid to parentid fo all array tables...</cfoutput><cfflush>
	<cftry>
		
		<cfset stArrayFields = StructNew() />
		<cfset stArrayFields.container.lfields = "aRules" />
		<cfloop list="#structKeyList(application.types)#" index="iType">
			
			<cfloop list="#structKeyList(application.types[iType].stProps)#" index="iField">
				<cfif application.types[iType].stprops[iField].metadata.Type EQ "Array">
					<cfparam name="stArrayFields[iType]" default="#structNew()#">
					<cfparam name="stArrayFields[iType].lFields" default="">
					<cfset stArrayFields[iType].lFields = ListAppend(stArrayFields[iType].lFields,iField) />
				</cfif>
			</cfloop>
			
		</cfloop>
		

		<cfloop list="#structKeyList(stArrayFields)#" index="iType">
			<cfloop list="#stArrayFields[iType].lFields#" index="iField">
				
		
					<cfswitch expression="#application.dbtype#">
						
						<cfcase value="ora">																
							<cftry>
								<cfquery name="qAlterTable" datasource="#application.dsn#">
								ALTER TABLE #application.dbowner##iType#_#iField# ADD typename VARCHAR2(255) NULL
								</cfquery>
								<cfoutput><div>Typename added to table #iType#_#iField#</div></cfoutput>
								<cfcatch type="database"><cfoutput><div>Typename already exists in table #iType#_#iField#</div></cfoutput></cfcatch>
							</cftry>

							<cftry>		
								<cfquery name="update" datasource="#application.dsn#">
								UPDATE #application.dbowner##iType#_#iField#
								SET #application.dbowner##iType#_#iField#.typename = refObjects.typename		
								FROM #application.dbowner##iType#_#iField# INNER JOIN #application.dbowner#refObjects
								ON #application.dbowner##iType#_#iField#.data=refObjects.objectid					
								</cfquery>	
								<cfoutput><div>Typename field updated in <strong>#application.dbowner##iType#_#iField#</strong></div></cfoutput>	
							
								<cfcatch type="database"><cfdump var="#cfcatch#" expand="false"></cfcatch>
							</cftry>
							
							<cftry>		
								<cfquery name="qAlterTable" datasource="#application.dsn#">
								ALTER TABLE #application.dbowner##iType#_#iField# RENAME COLUMN objectid TO parentid;
								</cfquery>
								<cfoutput><div>objectid renamed to parentid for #iType#_#iField#</div></cfoutput>
								<cfcatch type="database"><cfoutput><div>Rename of objectid column failed for in table #iType#_#iField#</div></cfoutput></cfcatch>
							</cftry>
						</cfcase>
						

						<cfcase value="mysql,mysql5">																
							<cftry>
								<cfquery name="qAlterTable" datasource="#application.dsn#">
								ALTER TABLE #application.dbowner##iType#_#iField# ADD typename VARCHAR(255) NULL
								</cfquery>
								<cfoutput><div>Typename added to table #iType#_#iField#</div></cfoutput>
								<cfcatch type="database"><cfoutput><div>Typename already exists in table #iType#_#iField#</div></cfoutput></cfcatch>
							</cftry>

							<cftry>
								<cfquery name="update" datasource="#application.dsn#">
								<!--- UPDATE #application.dbowner##iType#_#iField#
								SET #application.dbowner##iType#_#iField#.typename = refObjects.typename		
								FROM #application.dbowner##iType#_#iField# INNER JOIN #application.dbowner#refObjects
								ON #application.dbowner##iType#_#iField#.data=refObjects.objectid --->
								
								UPDATE #application.dbowner##iType#_#iField#
								SET #application.dbowner##iType#_#iField#.typename = 
										(SELECT refObjects.typename
                                    	 FROM refObjects
                                    	 WHERE #application.dbowner##iType#_#iField#.data=refObjects.objectid
                                    	 )
								</cfquery>
								
								<cfoutput><div>Typename field updated in <strong>#application.dbowner##iType#_#iField#</strong></div></cfoutput>	
							
								<cfcatch type="database"><cfdump var="#cfcatch#" expand="false"></cfcatch>
							</cftry>	

							<cftry>		
								<cfquery name="qAlterTable" datasource="#application.dsn#">
								ALTER TABLE #application.dbowner##iType#_#iField# RENAME COLUMN objectid TO parentid;
								</cfquery>
								<cfoutput><div>objectid renamed to parentid for #iType#_#iField#</div></cfoutput>
								<cfcatch type="database"><cfoutput><div>Rename of objectid column failed for in table #iType#_#iField#</div></cfoutput></cfcatch>
							</cftry>
							
												
						</cfcase>
						
						<cfcase value="postgresql">																
							<cftry>
								<cfquery name="qAlterTable" datasource="#application.dsn#">
								ALTER TABLE #application.dbowner##iType#_#iField# ADD typename VARCHAR(255) NULL
								</cfquery>
								<cfoutput><div>Typename added to table #iType#_#iField#</div></cfoutput>
								<cfcatch type="database"><cfoutput><div>Typename already exists in table #iType#_#iField#</div></cfoutput></cfcatch>
							</cftry>

							<cftry>
								<cfquery name="update" datasource="#application.dsn#">
								UPDATE #application.dbowner##iType#_#iField#
								SET #application.dbowner##iType#_#iField#.typename = refObjects.typename		
								FROM #application.dbowner##iType#_#iField# INNER JOIN #application.dbowner#refObjects
								ON #application.dbowner##iType#_#iField#.data=refObjects.objectid					
								</cfquery>	
								<cfoutput><div>Typename field updated in <strong>#application.dbowner##iType#_#iField#</strong></div></cfoutput>	
							
								<cfcatch type="database"><cfdump var="#cfcatch#" expand="false"></cfcatch>
							</cftry>
							
							<cftry>		
								<cfquery name="qAlterTable" datasource="#application.dsn#">
								ALTER TABLE #application.dbowner##iType#_#iField# RENAME COLUMN objectid TO parentid;
								</cfquery>
								<cfoutput><div>objectid renamed to parentid for #iType#_#iField#</div></cfoutput>
								<cfcatch type="database"><cfoutput><div>Rename of objectid column failed for in table #iType#_#iField#</div></cfoutput></cfcatch>
							</cftry>
												
						</cfcase>
	
						<cfcase value="mssql,odbc">																
							<cftry>
								<cfquery name="qAlterTable" datasource="#application.dsn#">
								ALTER TABLE #application.dbowner##iType#_#iField# ADD typename VARCHAR(255) NULL
								</cfquery>
								<cfoutput><div>Typename added to table #iType#_#iField#</div></cfoutput>
								<cfcatch type="database"><cfoutput><div>Typename already exists in table #iType#_#iField#</div></cfoutput></cfcatch>
							</cftry>

							<cftry>
								<cfquery name="update" datasource="#application.dsn#">
								UPDATE #application.dbowner##iType#_#iField#
								SET #application.dbowner##iType#_#iField#.typename = refObjects.typename		
								FROM #application.dbowner##iType#_#iField# INNER JOIN #application.dbowner#refObjects
								ON #application.dbowner##iType#_#iField#.data=refObjects.objectid					
								</cfquery>	
								<cfoutput><div>Typename field updated in <strong>#application.dbowner##iType#_#iField#</strong></div></cfoutput>	
							
								<cfcatch type="database"><cfdump var="#cfcatch#" expand="false"></cfcatch>
							</cftry>
							
							<cftry>		
								<cfquery name="qAlterTable" datasource="#application.dsn#">
									EXEC sp_rename 
								    @objname = '#application.dbowner##iType#_#iField#.objectid', 
								    @newname = 'parentid', 
								    @objtype = 'COLUMN'
								</cfquery>
								<cfoutput><div>objectid renamed to parentid for #iType#_#iField#</div></cfoutput>
								<cfcatch type="database"><cfoutput><div>Rename of objectid column failed for in table #iType#_#iField#</div></cfoutput></cfcatch>
							</cftry>
												
						</cfcase>					
						
						<cfdefaultcase>
							<cfthrow message="Your database type is not supported for this update (310)." /> 
						</cfdefaultcase>
					
					</cfswitch>

			</cfloop>
		</cfloop>
		

		<cfcatch><cfset error=1><cfoutput><p><span class="frameMenuBullet">&raquo;</span> <span class="error"><cfdump var="#cfcatch.detail#"></span></p></cfoutput></cfcatch>
	</cftry>

	<cfif not error>
		<cfoutput><strong>done</strong></p></cfoutput><cfflush>
	</cfif>
	
		
	
	
	

	<!---
		clean up caching: kill all shared scopes and force application initialisation
			- application
			- session
			- server.dmSec[application.applicationname]
	 --->
	<cfset application.init=false>
	<cfset session=structnew()>
	<cfset server.dmSec[application.applicationname] = StructNew()>
	<cfoutput><p><strong>All done.</strong> Return to <a href="#application.url.farcry#/index.cfm">FarCry Webtop</a>.</p></cfoutput>
	<cfflush>
<cfelse>
	<cfoutput>
	<p>
	<strong>This script :</strong>
	<ul>
		<li>Update Image Config</li>
		<li>Adds the SourceImage, StandardImage and ThumbnailImage entry to dmImage table</li>
		<li>Create SourceImages, thumbnailImages and StandardImages directories</li>
		<li>Update SourceImage, StandardImage and ThumbnailImage initial values</li>
		<li>Copy Files from Old Locations to New Locations</li>
		<li>Add new typename field to each array table</li>
		<li>Populate each new typename field with the typname of the objectid it contains.</li>
	</ul>
	</p>
	<form action="" method="post">
		<input type="hidden" name="dummy" value="1">
		<input type="submit" value="Run 4.0.0 Update" name="submit">
	</form>

	</cfoutput>
</cfif>

</body>
</html>