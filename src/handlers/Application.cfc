<!-----------------------------------------------------------------------
********************************************************************************
Copyright Since 2005 ColdBox Framework by Luis Majano and Ortus Solutions, Corp
www.coldboxframework.com | www.luismajano.com | www.ortussolutions.com
********************************************************************************

Author      :	 Sana Ullah & Luis Majano
Date        :	08/01/2009
----------------------------------------------------------------------->
<cfcomponent displayname="Application" output="false">
	
	<cfscript>
		this.name				= "ColdBoxCFBuilderExtension";
		this.sessionManagement	= true;
	</cfscript>

	<cffunction name="onRequest">
		<cfargument name="targetPage">
		
   		<cfsetting showdebugoutput="false">
		
		<!--- Param the incoming ide event info --->
		<cfparam name="ideeventinfo">
		
		<!--- Utility Class --->
		<cfset request.utility = createObject("component","util.Utility")>
		
		<!--- Log Request 
		<cflog file="ColdBoxCFBuilder" text="Executing #cgi.script_name# #timeFormat(now())#">
		<cflog file="ColdBoxCFBuilder" text="ideeventinfo: #ideeventinfo.toString()#">
		--->
		
		<!--- Parse incoming event info --->
		<cfset data = xmlParse(ideeventinfo)>
		
		<!--- Parse the incoming input values --->
		<cfset inputStruct = request.utility.parseInput(data)>
		
		<!--- Include page requested --->
		<cfinclude template="#arguments.targetPage#">
	</cffunction>
</cfcomponent>