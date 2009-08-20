<!-----------------------------------------------------------------------
Author 	 :	Sana Ullah
Date     :	August 1, 2009
Description :
---------------------------------------------------------------------->
<cfcomponent displayname="Application" output="false">
	<cfscript>
		this.name				= "ColdBoxBoltExtension";
		this.sessionManagement	= true;
	</cfscript>

	<cffunction name="onRequestStart">
		<cfsetting showdebugoutput="false">
	</cffunction>
</cfcomponent>