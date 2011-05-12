<!-----------------------------------------------------------------------
********************************************************************************
Copyright Since 2005 ColdBox Framework by Luis Majano and Ortus Solutions, Corp
www.coldboxframework.com | www.luismajano.com | www.ortussolutions.com
********************************************************************************

Author      :	 Sana Ullah & Luis Majano
Date        :	08/01/2009
----------------------------------------------------------------------->
<cfcomponent output="false">
	
	<cfscript>
		this.name				= "ColdBoxCFBuilderExtension_#hash(getCurrentTemplatePath())#";
		this.sessionManagement	= true;
		
		// Local Mappings for Extension
		this.mappings["/coldboxExtension"] = getDirectoryFromPath(getCurrentTemplatePath()) ;
	</cfscript>

	<!--- onRequest --->
	<cffunction name="onRequest">
		<cfargument name="targetPage">
		<cfsetting showdebugoutput="false">
		
		<!--- Param the incoming ide event info --->
		<cfparam name="ideeventinfo" default="">
		<cfparam name="data" 		 default="#structnew()#">
		
		<!--- Log Request 
		<cflog file="ColdBoxCFBuilder" text="Executing #cgi.script_name# #timeFormat(now())#">
		<cflog file="ColdBoxCFBuilder" text="ideeventinfo: #ideeventinfo.toString()#">
		--->
		
		<!--- Parse incoming event info if available? --->
		<cfif isXML( ideeventinfo )>
			<cfset data = xmlParse(ideeventinfo)>
		</cfif>
		
		<!--- place the ExtensionController on scope --->
		<cfset controller = getExtensionController(data)>
		<!--- Parse the incoming input values --->
		<cfset inputStruct = controller.parseInput(data)>
		
		<!--- Include page requested --->
		<cfinclude template="#arguments.targetPage#">
	</cffunction>
	
	<!--- getExtensionController --->
    <cffunction name="getExtensionController" output="false" access="private" returntype="any" hint="Get the extension controller">
    	<cfargument name="data">
    	<cfreturn createObject("component","coldboxExtension.model.ExtensionController").init(arguments.data)>
    </cffunction>

	
</cfcomponent>