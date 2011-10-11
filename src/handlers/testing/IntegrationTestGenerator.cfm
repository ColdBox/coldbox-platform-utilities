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
<cfset handlerName		= trim(inputstruct.Name) />

<!--- Script? --->
<cfset scriptPrefix 		= "">
<cfif inputStruct.Script>
	<cfset scriptPrefix 	= "Script">
</cfif>

<!--- Read in Templates --->
<cffile action="read" file="#expandPath('/coldboxExtension')#/templates/testing/HandlerTestContent#scriptPrefix#.txt"     variable="handlerTestContent">
<cffile action="read" file="#expandPath('/coldboxExtension')#/templates/testing/HandlerTestCaseContent#scriptPrefix#.txt" variable="handlerTestCaseContent">

<!--- Start text replacements --->
<cfset handlerTestContent = replaceNoCase(handlerTestContent,"|appMapping|",inputstruct.appMapping,"all") />

<!--- Handle Test Actions if passed --->
<cfif len(inputstruct.Actions)>
	<cfset allTestsCases = "">
	<cfset thisTestCase  = "">
	
	<!--- Loop Over test actions generating their functions --->
	<cfloop list="#inputStruct.Actions#" index="thisAction">
		<cfset thisTestCase = replaceNoCase(handlerTestCaseContent,"|action|",trim(thisAction),"all")>
		<cfset thisTestCase = replaceNoCase(thisTestCase,"|event|", handlerName & "." & trim(thisAction),"all")>
		<cfset allTestsCases = allTestsCases & thisTestCase & chr(13) & chr(13)/>
	</cfloop>
	
	<cfset handlerTestContent = replaceNoCase(handlerTestContent,"|TestCases|",allTestsCases,"all") />	
<cfelse>
	<cfset handlerTestContent = replaceNoCase(handlerTestContent,"|TestCases|",'',"all") />	
</cfif>

<!--- Write out the files --->
<cffile action="write" file="#expandLocation#/#handlerName#Test.cfc" mode ="777" output="#handlerTestContent#">

<cfheader name="Content-Type" value="text/xml">  
<cfoutput>
<response status="success" showresponse="true">  
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
	<dialog width="550" height="350" title="ColdBox Integration Test Wizard" image="includes/images/ColdBox_Icon.png"/>  
	<body><![CDATA[
	<html>
		<head>
			<base href="#controller.getBaseURL()#" />
			<link href="includes/css/styles.css" type="text/css" rel="stylesheet">
			<script type="text/javascript" src="includes/js/jquery.latest.min.js"></script>
		</head>
		<body>
			<div class="messagebox-green">Generated New Integration Test!</div>
			<p>
			Generated new integration test called: #handlerName#Test.cfc
			</p>
		</body>
	</html>	
	]]></body>
</ide>
</response>
</cfoutput>
