<!-----------------------------------------------------------------------
********************************************************************************
Copyright Since 2005 ColdBox Framework by Luis Majano and Ortus Solutions, Corp
www.coldboxframework.com | www.luismajano.com | www.ortussolutions.com
********************************************************************************

Author      :	Sana Ullah & Luis Majano

All handlers receive the following:
- data 		  : The data parsed
- inputStruct : A parsed input structure
----------------------------------------------------------------------->
<!--- Defaults --->
<cfset message 				= "" />
<cfset scriptPrefix 		= "">
<cfset expandLocation		= data.event.ide.projectview.resource.xmlAttributes.path />
<cfset testName				= listLast( inputStruct.interceptorPath, "." )>

<!--- Style Script Check, BDD is only script --->
<cfif inputStruct.style eq "BDD">
	<cfset inputStruct.script = true>
	<cfset style = "BDD">
<cfelse>
	<cfset style = "Test">
</cfif>

<!--- Script? --->
<cfif inputStruct.Script>
	<cfset scriptPrefix = "Script">
</cfif>

<!--- Read test template --->
<cffile action="read" file="#ExpandPath('/cpu')#/templates/testing/Interceptor#style#Content#scriptPrefix#.txt" 		variable="interceptorTestContent">
<cffile action="read" file="#ExpandPath('/cpu')#/templates/testing/Interceptor#style#CaseContent#scriptPrefix#.txt" 	variable="interceptorTestCaseContent">

<!--- Setup test Replacements --->
<cfset interceptorTestContent = replaceNoCase(interceptorTestContent,"|name|","#inputStruct.interceptorPath#","all") />

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
<cffile action="write" file="#expandLocation#/#testName#Test.cfc" mode ="777" output="#interceptorTestContent#">
<cfset message &= "<br/>Generated new test interceptor object." />
<cfcatch type="any">
	<cfset message &= "<br/>There was problem creating interceptor test object: #cfcatch.message#" />
	</cfcatch>
</cftry>

<cfheader name="Content-Type" value="text/xml">
<cfoutput>
<response status="success" showresponse="false">
<ide>
	<commands>
		<command type="RefreshProject">
			<params>
			    <param key="projectname" value="#data.event.ide.projectview.xmlAttributes.projectname#" />
			</params>
		</command>
		<command type="openfile">
			<params>
			    <param key="filename" value="#expandLocation#/#testName#Test.cfc" />
			</params>
		</command>
	</commands>
</ide>
</response>
</cfoutput>
