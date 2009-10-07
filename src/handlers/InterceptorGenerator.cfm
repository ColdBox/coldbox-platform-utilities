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

<!--- Expand Locations --->
<cfset expandLocation	= data.event.ide.projectview.resource.xmlAttributes.path />
<cfset interceptorName		= inputstruct.Name />
<cfset scriptPrefix = "">
<!--- Script? --->
<cfif inputStruct.Script>
	<cfset scriptPrefix = "Script">
</cfif>

<!--- Read in Template --->
<cffile action="read" file="#ExpandPath('../')#/templates/InterceptorContent#scriptPrefix#.txt" variable="interceptorContent">
<cffile action="read" file="#ExpandPath('../')#/templates/InterceptorMethod#scriptPrefix#.txt" variable="interceptorMethod">

<!--- Start Replacings --->
<cfset interceptorContent = replaceNoCase(interceptorContent,"|Name|",inputstruct.Name,"all") />

<!--- Description --->
<cfif len(inputstruct.Description)>
	<cfset interceptorContent = replaceNoCase(interceptorContent,"|Description|",inputstruct.Description,"all") />
<cfelse>
	<cfset interceptorContent = replaceNoCase(interceptorContent,"|Description|",defaultDescription,"all") />	
</cfif>

<!--- Interception Points --->
<cfif len(inputstruct.InterceptionPoints)>
	<cfset methodContent = "">
	<cfloop list="#inputStruct.InterceptionPoints#" index="thisPoint">
		<cfset methodContent = methodContent & replaceNoCase(interceptorMethod,"|interceptionPoint|",thisPoint,"all") & chr(13) & chr(13) />
	</cfloop>
	<cfset interceptorContent = replaceNoCase(interceptorContent,"|interceptionPoints|",methodContent,"all") />	
<cfelse>
	<cfset interceptorContent = replaceNoCase(interceptorContent,"|interceptionPoints|",'',"all") />	
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
<cfoutput>
<response status="success" showresponse="true">  
<ide>  
	<commands>
		<command type="RefreshProject">
			<params>
			    <param key="projectname" value="#data.event.ide.projectview.xmlAttributes.projectname#" />
			</params>
		</command>
		<command type="openfile">
			<params>
			    <param key="filename" value="#expandLocation#/#interceptorName#.cfc" />
			</params>
		</command>
	</commands>
	<dialog width="550" height="350" title="ColdBox Interceptor Wizard" image="images/ColdBox_Icon.png"/>  
	<body><![CDATA[<p style="font-size:12px;"><cfoutput>#message#</cfoutput></p>]]></body>
</ide>
</response>
</cfoutput>
