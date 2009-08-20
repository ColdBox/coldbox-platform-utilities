<!-----------------------------------------------------------------------
Author 	 :	Sana Ullah
Date     :	August 1, 2009
Description :
---------------------------------------------------------------------->

<cflog file="ColdBoxCFBuilder" text="Running ExpandAppSkeleton.cfm #timeFormat(now())#">
<cfparam name="ideeventinfo"> 
<cfset data = xmlParse(ideeventinfo)>

<cfset message = "" />
<cfset expandLocation	= data.event.ide.projectview.resource.xmlAttributes.path />
<cfset skeletonLocation	= data.event.user.input.xmlAttributes.value />

<!--- get the zip file under the skeleton location directory. I ignore any but the first one --->
<cfdirectory action="list" directory="#expandPath('../skeletons/#skeletonLocation#')#" filter="*.zip" name="appSkeletonsZip" />

<cfif appSkeletonsZip.recordCount>
	<cfzip action="unzip" destination="#expandLocation#" file="#appSkeletonsZip.directory#/#appSkeletonsZip.name#" storePath="true" recurse="yes" />
	<cfset message = appSkeletonsZip.name & " unzipped to " & expandLocation />
<cfelse>
	<cfset message = "No zip file was found in that directory." />
</cfif>

<cfheader name="Content-Type" value="text/xml">  
<response status="success" showresponse="true">  
<ide>  
<dialog width="550" height="350" />  
<body><![CDATA[<p style="font-size:11px;"><cfoutput>#message#</cfoutput></p>]]></body>
</ide>
</response>

