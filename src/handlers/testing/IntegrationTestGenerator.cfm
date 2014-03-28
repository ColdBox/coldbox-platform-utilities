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
<!--- Setup Variables --->
<cfset message				= "" />
<cfset expandLocation	= data.event.ide.projectview.resource.xmlAttributes.path />
<cfset projectname		= data.event.ide.projectview.xmlAttributes.projectname>
<cfset handlerName		= trim( inputstruct.Name ) />

<!--- Style Script Check, BDD is only script --->
<cfif inputStruct.style eq "BDD">
	<cfset inputStruct.script = true>
	<cfset style = "BDD">
<cfelse>
	<cfset style = "Test">
</cfif>

<!--- Script? --->
<cfset scriptPrefix = "">
<cfif inputStruct.Script>
	<cfset scriptPrefix 	= "Script">
</cfif>

<!--- Read in Templates --->
<cffile action="read" file="#expandPath( '/cpu' )#/templates/testing/Handler#style#Content#scriptPrefix#.txt"     variable="handlerTestContent">
<cffile action="read" file="#expandPath( '/cpu' )#/templates/testing/Handler#style#CaseContent#scriptPrefix#.txt" variable="handlerTestCaseContent">

<!--- Start text replacements --->
<cfset handlerTestContent = replaceNoCase( handlerTestContent, "|appMapping|", inputstruct.appMapping, "all" ) />
<cfset handlerTestContent = replaceNoCase( handlerTestContent, "|handlerName|", handlerName, "all" ) />

<!--- Handle Test Actions if passed --->
<cfif len(inputstruct.Actions)>
	<cfset allTestsCases = "">
	<cfset thisTestCase  = "">

	<!--- Loop Over test actions generating their functions --->
	<cfloop list="#inputStruct.Actions#" index="thisAction">
		<cfset thisTestCase = replaceNoCase( handlerTestCaseContent,"|action|",trim( thisAction ),"all")>
		<cfset thisTestCase = replaceNoCase( thisTestCase,"|event|", handlerName & "." & trim( thisAction ),"all")>
		<cfset allTestsCases = allTestsCases & thisTestCase & chr(13) & chr(13)/>
	</cfloop>

	<cfset handlerTestContent = replaceNoCase( handlerTestContent, "|TestCases|", allTestsCases, "all") />
<cfelse>
	<cfset handlerTestContent = replaceNoCase( handlerTestContent, "|TestCases|", '', "all") />
</cfif>

<!--- Write out the files --->
<cffile action="write" file="#expandLocation#/#handlerName#Test.cfc" mode ="777" output="#handlerTestContent#">

<cfheader name="Content-Type" value="text/xml">
<cfoutput>
<response status="success" showresponse="false">
<ide>
	<commands>
		<command type="refreshfolder" />
		<command type="refreshproject">
			<params>
			    <param key="projectname" value="#projectname#" />
			</params>
		</command>
		<command type="openfile">
			<params>
			    <param key="filename" value="#expandLocation#/#handlerName#Test.cfc" />
			</params>
		</command>
	</commands>
</ide>
</response>
</cfoutput>
