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
<cfset testName				= listLast(inputStruct.pluginPath,".")>
<!--- Script? --->
<cfif inputStruct.Script>
	<cfset scriptPrefix = "Script">
</cfif>
<!--- Read test template --->
<cffile action="read" file="#expandPath('/coldboxExtension')#/templates/testing/PluginTestContent#scriptPrefix#.txt" variable="pluginTestContent">
<cfset pluginTestContent = replaceNoCase(pluginTestContent,"|pluginName|", inputStruct.pluginPath, "all") />
<!--- Write it back out --->
<cftry>
	<cffile action="write" file="#expandLocation#/#testName#Test.cfc" mode ="777" output="#pluginTestContent#">
	<cfset message &= "<br/>Generated new test plugin object." />
	<cfcatch type="any">
		<cfset message &= "<br/>There was problem creating plugin test object: #cfcatch.message#" />
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
			    <param key="filename" value="#expandLocation#/#testName#Test.cfc" />
			</params>
		</command>
	</commands>
	<dialog width="550" height="350" title="ColdBox Plugin Test Wizard" image="includes/images/ColdBox_Icon.png"/>  
	<body>
	<![CDATA[
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
	]]>
	</body>
</ide>
</response>
</cfoutput>
