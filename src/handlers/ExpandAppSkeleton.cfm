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
	<cfset expandLocation	= data.event.ide.projectview.resource.xmlAttributes.path />
<cfelse>
	<cfset expandLocation	= data.event.ide.eventinfo.xmlAttributes.projectLocation />
</cfif>

<!--- get the zip file under the skeleton location directory. I ignore any but the first one --->
<cfdirectory action="list" directory="#expandPath('../skeletons/#inputStruct.ApplicationType#')#" filter="*.zip" name="appSkeletonsZip" />

<!--- Unzip it --->
<cfif appSkeletonsZip.recordCount>
	<cfzip action="unzip" destination="#expandLocation#" file="#appSkeletonsZip.directory#/#appSkeletonsZip.name#" storePath="true" recurse="yes" />
	<cfset message = appSkeletonsZip.name & " succesfully generated!" />
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
		<command type="RefreshProject">
			<params>
			    <param key="projectname" value="#expandLocation#" />
			</params>
		</command>
		<command type="openfile">
			<params>
			    <param key="filename" value="#expandLocation#/config/coldbox.xml.cfm" />
			</params>
		</command>
	</commands>
	<dialog width="550" height="350" title="ColdBox Application Generator Wizard" image="images/ColdBox_Icon.png"/>  
	<body><![CDATA[<p style="font-size:11px;"><cfoutput>#message#</cfoutput></p>]]></body>
</ide>
</response>
</cfoutput>

