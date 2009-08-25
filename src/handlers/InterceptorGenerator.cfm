<!-----------------------------------------------------------------------
Author 	 :	Sana Ullah
Date     :	August 1, 2009
Description :
---------------------------------------------------------------------->
<!--- set handler properties default values --->
<cfset defaultDescription 	= "I am a new interceptor" />
<cfset defaultName			= "" />
<cfset message	= "" /> 
<cfset data		= xmlParse(ideeventinfo)>

<cfset extxmlinput = xmlSearch(data, "/event/user/input")>
<cfset inputstruct = StructNew()>

<cfloop index="i" from="1" to="#arrayLen(extxmlinput)#" >
	<cfset StructInsert(inputstruct,"#extxmlinput[i].xmlAttributes.name#","#extxmlinput[i].xmlAttributes.value#")>
</cfloop>

<!--- ======================================================================= --->
<cfif not len(inputstruct.name)>
	<cfset message = "The interceptor name cannot be empty" />
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

<!--- Expand Locations --->
<cfset expandLocation	= data.event.ide.projectview.resource.xmlAttributes.path />
<cfset interceptorName		= inputstruct.Name />

<!--- Read in Template --->
<cffile action="read" file="#ExpandPath('../')#/templates/InterceptorContent.txt" variable="interceptorContent">

<!--- Start Replacings --->
<cfset interceptorContent = replaceNoCase(interceptorContent,"|Name|",inputstruct.Name,"all") />

<cfif len(inputstruct.Description)>
	<cfset interceptorContent = replaceNoCase(interceptorContent,"|Description|",inputstruct.Description,"all") />
<cfelse>
	<cfset interceptorContent = replaceNoCase(interceptorContent,"|Description|",defaultDescription,"all") />	
</cfif>

<!--- Write it out. --->
<cftry>
	<cffile action="write" file="#expandLocation#/#interceptorName#.cfc" mode ="777" output="#interceptorContent#">
	<cfset message = interceptorName & ".cfc Generated new interceptor" />
<cfcatch type="any">
	<cfset message = "There was problem creating interceptor: #cfcatch.message#" />
</cfcatch>
</cftry>

<cfheader name="Content-Type" value="text/xml">  
<response status="success" showresponse="true">  
<ide>  
	<dialog width="550" height="350" title="ColdBox Interceptor Wizard" image="images/ColdBox_Icon.png"/>  
	<body><![CDATA[<p style="font-size:12px;"><cfoutput>#message#</cfoutput></p>]]></body>
</ide>
</response>

