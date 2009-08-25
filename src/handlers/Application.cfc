<!-----------------------------------------------------------------------
Author 	 :	Sana Ullah
Date     :	August 1, 2009
Description :
---------------------------------------------------------------------->
<cfcomponent displayname="Application" output="false">
	<cfscript>
		this.name				= "ColdBoxCFBuilderExtension";
		this.sessionManagement	= true;
	</cfscript>

	<cffunction name="onRequestStart">
		<cfsetting showdebugoutput="false">
		
		<!--- Param the incoming ide event info --->
		<cfparam name="ideeventinfo">
		
		<!--- Log Request --->
		<cflog file="ColdBoxCFBuilder" text="Executing #cgi.script_name# #timeFormat(now())#">
		<cflog file="ColdBoxCFBuilder" text="ideeventinfo: #ideeventinfo.toString()#">
		
		
	</cffunction>
</cfcomponent>