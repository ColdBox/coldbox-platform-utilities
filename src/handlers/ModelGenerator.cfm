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

<cfset defaultDescription 	= "I am a new Model Object" />
<cfset defaultSingleton 	= "false">
<cfset defaultCache			= "false" />
<cfset defaultCacheTimeout  = "" >
<cfset message 				= "" />
<cfset expandLocation		= data.event.ide.projectview.resource.xmlAttributes.path />
<cfset modelName			= inputstruct.Name />
<cfset scriptPrefix 		= "">

<!--- Script? --->
<cfif inputStruct.Script>
	<cfset scriptPrefix = "Script">
</cfif>

<!--- Read Model Template --->
<cffile action="read" file="#ExpandPath('../')#/templates/ModelContent#scriptPrefix#.txt" variable="modelContent">

<cfset modelContent = replaceNoCase(modelContent,"|modelName|",modelName,"all") />

<cfif len(inputstruct.Description)>
	<cfset modelContent = replaceNoCase(modelContent,"|modelDescription|",inputstruct.Description,"all") />
<cfelse>
	<cfset modelContent = replaceNoCase(modelContent,"|modelDescription|",defaultDescription,"all") />	
</cfif>

<cfswitch expression="#inputStruct.Persistence#">
	<cfcase value="Transient">
		<cfset modelContent = replaceNoCase(modelContent,"|modelPersistence|","","all") />
	</cfcase>
	<cfcase value="Time Persisted">
		<cfset cacheString = 'cache="true"'>
		<cfif len(inputStruct.cacheTimeout)>
			<cfset cacheString = cacheString & ' cacheTimeout="#inputStruct.cacheTimeout#"'>
		</cfif>
		<cfset modelContent = replaceNoCase(modelContent,"|modelPersistence|",cacheString,"all") />
	</cfcase>
	<cfcase value="Singleton">
		<cfset modelContent = replaceNoCase(modelContent,"|modelPersistence|",'singleton',"all") />
	</cfcase>
</cfswitch>

<!--- Write it back out --->
<cftry>
	<cffile action="write" file="#expandLocation#/#modelName#.cfc" mode ="777" output="#modelContent#">
	<cfset message = modelName & ".cfc Generated new model object" />
	
	<cfcatch type="any">
		<cfset message = "There was problem creating model object: #cfcatch.message#" />
	</cfcatch>
</cftry>

<!--- Testing? --->
<cfif inputStruct.GenerateTest>
	<!--- Read test template --->
	<cffile action="read" file="#ExpandPath('../')#/templates/testing/ModelTestContent#scriptPrefix#.txt" variable="modelTestContent">
	<cfset modelTestContent = replaceNoCase(modelTestContent,"|modelName|","{PATH_TO.}#modelName#","all") />
	<!--- Write it back out --->
	<cftry>
		<cffile action="write" file="#inputStruct.TestsDirectory#/#modelName#Test.cfc" mode ="777" output="#modelTestContent#">
		<cfset message &= "<br/>Generated new test model object." />
		<cfcatch type="any">
			<cfset message &= "<br/>There was problem creating model test object: #cfcatch.message#" />
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
			    <param key="filename" value="#expandLocation#/#modelName#.cfc" />
			</params>
		</command>
		<cfif inputStruct.GenerateTest>
		<command type="openfile">
			<params>
			    <param key="filename" value="#inputStruct.TestsDirectory#/#modelName#Test.cfc" />
			</params>
		</command>
		</cfif>
	</commands>
	<dialog width="550" height="350" title="New ColdBox Model Wizard" image="includes/images/ColdBox_Icon.png"/>  
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
