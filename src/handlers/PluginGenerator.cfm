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
<cfset pluginName		= data.event.user.input.xmlAttributes.value />

<cffile action="read" file="#ExpandPath('../')#/files/PluginContent.txt" variable="pluginContent">

<cftry>
	<cffile action="write" file="#expandLocation#/#pluginName#.cfc" mode ="777" output="#pluginContent#">
	<cfset message = pluginName & ".cfc Generated new plugin" />
<cfcatch type="any">
	<cfset message = "There was problem creating plugin: #cfcatch.message#" />
</cfcatch>
</cftry>

<cfheader name="Content-Type" value="text/xml">  
<response status="success" showresponse="true">  
<ide>  
<dialog width="550" height="350" />  
<body>
<![CDATA[<p style="font-size:12px;"><cfoutput>#message#</cfoutput></p>]]>
</body>
</ide>
</response>

