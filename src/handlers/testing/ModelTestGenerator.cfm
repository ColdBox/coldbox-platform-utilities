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
<cfset testName				= listLast( inputStruct.modelPath, "." )>

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
<cffile action="read" file="#expandPath('/cpu')#/templates/testing/Model#style#Content#scriptPrefix#.txt" variable="modelTestContent">
<cfset modelTestContent = replaceNoCase( modelTestContent, "|modelName|", inputStruct.modelPath, "all" ) />

<!--- Write it back out --->
<cftry>
	<cffile action="write" file="#expandLocation#/#testName#Test.cfc" mode ="777" output="#modelTestContent#">
	<cfset message &= "<br/>Generated new test model object." />
	<cfcatch type="any">
		<cfset message &= "<br/>There was problem creating model test object: #cfcatch.message#" />
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
