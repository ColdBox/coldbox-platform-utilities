<!-----------------------------------------------------------------------
Author 	 :	Sana Ullah
Date     :	August 1, 2009
Description :
---------------------------------------------------------------------->

<cflog file="ColdBoxCFBuilder" text="Running ExpandAppSkeleton.cfm #timeFormat(now())#">
<cfparam name="ideeventinfo">
<!--- set plugin properties default values --->
<cfset defaultDescription 	= "I am new handler" />
<cfset defaultName			= "" />

<cfset message	= "" /> 
<cfset data		= xmlParse(ideeventinfo)>

<cfset extxmlinput = xmlSearch(data, "/event/user/input")>
<cfset inputstruct = StructNew()>

<cfloop index="i" from="1" to="#arrayLen(extxmlinput)#" >
	<cfset StructInsert(inputstruct,"#extxmlinput[i].xmlAttributes.name#","#extxmlinput[i].xmlAttributes.value#")>
</cfloop>

<!--- ======================================================================= --->
<cfif not len(inputstruct.Name)>
	<cfset message = "The plugin cannot be empty" />
	<cfheader name="Content-Type" value="text/xml">  
	<response status="success" showresponse="true">  
	<ide>  
	<dialog width="550" height="350" />  
	<body>
	<![CDATA[<p style="font-size:12px;"><cfoutput>#message#</cfoutput></p>]]>
	</body>
	</ide>
	</response>
	
	<cfabort>
</cfif>
<!--- ======================================================================= --->

<cfset expandLocation	= data.event.ide.projectview.resource.xmlAttributes.path />
<cfset handlerName		= inputstruct.Name />

<cffile action="read" file="#ExpandPath('../')#/templates/HandlerContent.txt" variable="handlerContent">

<cfset handlerContent = replaceNoCase(handlerContent,"|Name|",inputstruct.Name,"all") />

<cfif len(inputstruct.Description)>
	<cfset handlerContent = replaceNoCase(handlerContent,"|Description|",inputstruct.Description,"all") />
<cfelse>
	<cfset handlerContent = replaceNoCase(handlerContent,"|Description|",defaultDescription,"all") />	
</cfif>

<cftry>
	<cffile action="write" file="#expandLocation#/#handlerName#.cfc" mode ="777" output="#handlerContent#">
	<cfset message = handlerName & ".cfc Generated new handler" />
<cfcatch type="any">
	<cfset message = "There was problem creating handler: #cfcatch.message#" />
</cfcatch>
</cftry>

<cfheader name="Content-Type" value="text/xml">  
<response status="success" showresponse="true">  
<ide>  
<dialog width="550" height="350" />  
<body><![CDATA[<p style="font-size:12px;"><cfoutput>#message#</cfoutput></p>]]></body>
</ide>
</response>

