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
<cffile action="read" file="#ExpandPath('/coldboxextension')#/templates/InterceptorContent#scriptPrefix#.txt" variable="interceptorContent">
<cffile action="read" file="#ExpandPath('/coldboxextension')#/templates/InterceptorMethod#scriptPrefix#.txt" variable="interceptorMethod">

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

<!--- Testing? --->
<cfif inputStruct.GenerateTest>
	<!--- Read test template --->
	<cffile action="read" file="#ExpandPath('../')#/templates/testing/InterceptorTestContent#scriptPrefix#.txt" 	variable="interceptorTestContent">
	<cffile action="read" file="#ExpandPath('../')#/templates/testing/InterceptorTestCaseContent#scriptPrefix#.txt" variable="interceptorTestCaseContent">
	<!--- Setup test Replacements --->
	<cfset interceptorTestContent = replaceNoCase(interceptorTestContent,"|name|","{PATH_TO.}#interceptorName#","all") />
	
	<!--- Handle Interception Point Tests--->
	<cfif len(inputstruct.InterceptionPoints)>
		<cfset allTestsCases = "">
		<cfset thisTestCase  = "">
		
		<!--- Loop Over test actions generating their functions --->
		<cfloop list="#inputStruct.InterceptionPoints#" index="thisPoint">
			<cfset thisTestCase = replaceNoCase(interceptorTestCaseContent,"|point|",trim(thisPoint),"all")>
			<cfset allTestsCases = allTestsCases & thisTestCase & chr(13) & chr(13)/>
		</cfloop>
		
		<!--- Replace all test cases --->
		<cfset interceptorTestContent = replaceNoCase(interceptorTestContent,"|TestCases|",allTestsCases,"all") />	
	<cfelse>
		<cfset interceptorTestContent = replaceNoCase(interceptorTestContent,"|TestCases|",'',"all") />	
	</cfif>
		
	<!--- Write it back out --->
	<cftry>
		<cffile action="write" file="#inputStruct.TestsDirectory#/#interceptorName#Test.cfc" mode ="777" output="#interceptorTestContent#">
		<cfset message &= "<br/>Generated new test interceptor object." />
		<cfcatch type="any">
			<cfset message &= "<br/>There was problem creating interceptor test object: #cfcatch.message#" />
		</cfcatch>
	</cftry>
</cfif>

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
		<cfif inputStruct.GenerateTest>
		<command type="openfile">
			<params>
			    <param key="filename" value="#inputStruct.TestsDirectory#/#interceptorName#Test.cfc" />
			</params>
		</command>
		</cfif>
	</commands>
	<dialog width="550" height="350" title="ColdBox Interceptor Wizard" image="includes/images/ColdBox_Icon.png"/>  
	<body><![CDATA[
	<html>
		<head>
			<base href="#controller.getBaseURL()#" />
			<link href="includes/css/styles.css" type="text/css" rel="stylesheet">
			<script type="text/javascript" src="includes/js/jquery.latest.min.js"></script>
		</head>
		<body>
			<div class="messagebox-green">#message#</div>
		</body>
	</html>	
	]]></body>
</ide>
</response>
</cfoutput>
