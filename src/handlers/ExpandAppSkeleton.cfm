<!-----------------------------------------------------------------------
Author 	 :	Sana Ullah
Date     :	August 1, 2009
Description :
---------------------------------------------------------------------->
<cfset data = xmlParse(ideeventinfo)>
<cfset message = "" />

<!--- Check if is an event or normal project view location? --->
<cfif structKeyExists(data.event.ide,"projectview")>
	<cfset expandLocation	= data.event.ide.projectview.resource.xmlAttributes.path />
<cfelse>
	<cfset expandLocation	= data.event.ide.eventinfo.xmlAttributes.projectLocation />
</cfif>

<!--- Parse Input --->
<cfset extXMLInput = xmlSearch(data, "/event/user/input")>
<cfset inputStruct = StructNew()>
<cfloop index="i" from="1" to="#arrayLen(extXMLInput)#" >
	<cfset StructInsert(inputStruct,"#extXMLInput[i].xmlAttributes.name#","#extXMLInput[i].xmlAttributes.value#")>
</cfloop>

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
<response status="success" showresponse="true">  
<ide>  
	<dialog width="550" height="350" title="ColdBox Application Generator Wizard" image="images/ColdBox_Icon.png"/>  
	<body><![CDATA[<p style="font-size:11px;"><cfoutput>#message#</cfoutput></p>]]></body>
</ide>
</response>

