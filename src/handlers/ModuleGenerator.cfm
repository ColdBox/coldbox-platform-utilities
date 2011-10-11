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

<cfset message 			= "" />
<cfset expandLocation	= data.event.ide.projectview.resource.xmlAttributes.path />
<cfset moduleName		= inputstruct.title />
<cfset scriptPrefix 	= "">

<!--- Script? --->
<cfif inputStruct.Script>
	<cfset scriptPrefix = "Script">	
</cfif>		
		
<!--- Read in Module Config --->
<cffile action="read" file="#ExpandPath('../')#/templates/modules/ModuleConfig#scriptPrefix#.cfc" variable="moduleConfig">

<!--- Start Generation Replacing --->
<cfset moduleConfig = replaceNoCase(moduleConfig,"@title@",moduleName,"all") />
<cfset moduleConfig = replaceNoCase(moduleConfig,"@author@",inputStruct.author,"all") />
<cfset moduleConfig = replaceNoCase(moduleConfig,"@authorURL@",inputStruct.authorURL,"all") />
<cfset moduleConfig = replaceNoCase(moduleConfig,"@description@",inputStruct.description,"all") />
<cfset moduleConfig = replaceNoCase(moduleConfig,"@version@",inputStruct.version,"all") />

<cftry>
	<!--- Copy module template --->	
	<cfset controller.getUtility().directoryCopy("#ExpandPath('../')#/templates/modules/", expandLocation & "/#moduleName#")>
	
	<!--- Clean Files Out --->
	<cfif inputStruct.Script>
		<cfset fileDelete(expandLocation & "/#moduleName#/handlers/Home.cfc")>
		<cfset fileMove(expandLocation & "/#moduleName#/handlers/HomeScript.cfc",expandLocation & "/#moduleName#/handlers/Home.cfc")>
	<cfelse>
		<cfset fileDelete(expandLocation & "/#moduleName#/handlers/HomeScript.cfc")>
	</cfif>
	<cfset fileDelete(expandLocation & "/#moduleName#/ModuleConfigScript.cfc")>
		
	<!--- Write Out the New Config --->
	<cfset fileWrite(expandLocation & "/#moduleName#/ModuleConfig.cfc",moduleConfig)>
	
	<cfset message = "Generated new module: #moduleName# in your application"/>
	
	<cfcatch type="any">
		<cfset message = "There was problem creating the module: #cfcatch.message# #cfcatch.detail#" />
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
			    <param key="filename" value="#expandLocation#/#moduleName#/ModuleConfig.cfc" />
			</params>
		</command>
	</commands>
	<dialog width="550" height="350" title="ColdBox Module Wizard" image="includes/images/ColdBox_Icon.png"/>  
	<body>
	<![CDATA[<p style="font-size:12px;"><cfoutput>#message#</cfoutput></p>]]>
	</body>
</ide>
</response>
</cfoutput>

