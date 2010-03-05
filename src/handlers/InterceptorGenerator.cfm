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

<!--- set handler properties default values --->
<cfset defaultDescription 	= "I am a new interceptor" />
<cfset defaultName			= "" />
<cfset message	= "" /> 

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
