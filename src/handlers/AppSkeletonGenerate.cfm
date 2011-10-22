<!-----------------------------------------------------------------------
********************************************************************************
Copyright Since 2005 ColdBox Framework by Luis Majano and Ortus Solutions, Corp
www.coldboxframework.com | www.luismajano.com | www.ortussolutions.com
********************************************************************************

Author      :	Sana Ullah & Luis Majano
Date        :	08/01/2009

All handlers receive the following:
- data 		  : The data parsed
- inputStruct : A parsed input structure
----------------------------------------------------------------------->
<cfset message = "" />
<!--- Check if is an event or normal project view location? --->
<cfif structKeyExists(data.event.ide,"projectview")>
	<cfset expandLocation	= data.event.ide.projectview.resource.xmlAttributes.path >
	<cfset projectname		= data.event.ide.projectview.xmlAttributes.projectname>
<cfelse>
	<cfset expandLocation	= data.event.ide.eventinfo.xmlAttributes.projectLocation >
	<cfset projectname		= data.event.ide.eventinfo.xmlAttributes.projectname >
</cfif>
<!--- get the zip file under the skeleton location directory. I ignore any but the first one --->
<cfdirectory action="list" directory="#expandPath('../skeletons/#inputStruct.ApplicationType#')#" filter="*.zip" name="appSkeletonsZip" />

<!--- Unzip it --->
<cfif appSkeletonsZip.recordCount>
	<cfzip action="unzip" destination="#expandLocation#" file="#appSkeletonsZip.directory#/#appSkeletonsZip.name#" storePath="true" recurse="yes" />
	<cfset message = listFirst(appSkeletonsZip.name,".") & " application skeleton succesfully generated!" />
<cfelse>
	<cfset message = "No zip file was found in that directory." />
</cfif>

<!--- Which Application.cfc to use. --->
<cfif inputStruct.ApplicationCFCType>
	<!--- Remove non-ineritance cfc --->
	<cfif fileExists(expandLocation & "/Application_noinheritance.cfc")>
		<cfset fileDelete(expandLocation & "/Application_noinheritance.cfc")>
	</cfif>
<cfelse>
	<!--- Remove ineritance cfc & rename it --->
	<cfif fileExists(expandLocation & "/Application_noinheritance.cfc")>
		<cfset fileDelete(expandLocation & "/Application.cfc")>
		<cfset fileMove(expandLocation & "/Application_noinheritance.cfc", expandLocation & "/Application.cfc")>
	</cfif>
</cfif>

<cfheader name="Content-Type" value="text/xml">  
<cfoutput>
<response status="success" showresponse="true">  
<ide> 
	<commands>
		<command type="refreshfolder" />
		<command type="refreshproject">
			<params>
			    <param key="projectname" value="#projectname#" />
			</params>
		</command>
		<command type="openfile">
			<params>
				<cfif fileExists(expandLocation & "/config/Coldbox.cfc")>
					<param key="filename" value="#expandLocation#/config/Coldbox.cfc" />
				<cfelseif fileExists(expandLocation & "/config/coldbox.xml.cfm")>
					<param key="filename" value="#expandLocation#/config/coldbox.xml.cfm" />
				</cfif>
			</params>
		</command>
	</commands>
	<dialog width="600" height="350" title="ColdBox Application Generator Wizard" image="includes/images/ColdBox_Icon.png"/>  
	<body><![CDATA[
	<html>
		<head>
			<base href="#controller.getBaseURL()#" />
			<link href="includes/css/styles.css" type="text/css" rel="stylesheet">
			<script type="text/javascript" src="includes/js/jquery.latest.min.js"></script>
		</head>
		<body>
			<div class="messagebox-green">#message#</div>
			<h2>Important Note</h2>
			<p>If you generated a Flex/Air Remote application, please make sure that you open the Application.cfc and modifty
				the <strong>COLDBOX_APP_MAPPING</strong> variable.  This is what your application needs in order to load itself remotely.
			</p>
		</body>
	</html>	
	]]></body>
</ide>
</response>
</cfoutput>

