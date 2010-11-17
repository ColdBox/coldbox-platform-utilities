<cfcomponent output="false">	<cfscript>		this.event_cache_suffix = "";		this.prehandler_only 	= "";		this.prehandler_except 	= "";		this.posthandler_only 	= "";		this.posthandler_except = "";		this.aroundHandler_only = "";		this.aroundHandler_except = "";				/* HTTP Methods Allowed for actions. */		/* Ex: this.allowedMethods = {delete='POST,DELETE',index='GET'} */		this.allowedMethods = structnew();	</cfscript><!----------------------------------------- IMPLICIT EVENTS ------------------------------------------>
	<!------------------------------------------- PUBLIC EVENTS ------------------------------------------>
	<!--- Default Action --->	<cffunction name="index" returntype="void" output="false" hint="My main event">		<cfargument name="event" required="true">		<cfset var rc = event.getCollection()>		<cfset var prc = event.getCollection(private=true)>		<cfset rc.welcomeMessage = "Welcome to ColdBox!">		<!---			Load some data into Request Collection			to show the RC Panel in ColdBox Debugger.		--->		<cfset rc['What_is_RC'] 	= 'The RC (public request collection) is where all user input is collected. This includes the FORM and URL scopes.' />		<cfset prc['What_is_PRC']  = 'The PRC (private request collection) can only be populated by the developer. A great place to place trusted data.' />		<cfset rc.query = queryNew('id,value') />		<cfset rc.array 	= arrayNew(1) />		<cfset arrayAppend(rc.array, 'I am an Array.') />		<cfset rc.xml 		= xmlNew(false) />		<cfset rc.struct = structNew() />		<cfset rc.struct.array = rc.array />		<cfset rc.binary = toBinary( toBase64('ColdBox') ) />		<cfset rc.object = createObject( "java", "java.net.Socket") />		<cfset event.setView("home")>	</cffunction>	<!--- Do Something Action --->	<cffunction name="doSomething" returntype="void" output="false" hint="Do Something">		<cfargument name="event" required="true">		<cfset var rc = event.getCollection()>		<cfset setNextEvent("general.index")>	</cffunction><!------------------------------------------- PRIVATE EVENTS ------------------------------------------>
	<cffunction name="preHandler" returntype="void" output="false" hint="Executes before any event in this handler">
		<cfargument name="event">
		<cfargument name="action" hint="The intercepted action"/>
		<cfargument name="eventArguments" hint="The event arguments an event is executed with (if any)"/>
		<cfscript>
			var rc = event.getCollection();
		</cfscript>
	</cffunction>
	<cffunction name="aroundHandler" returntype="void" output="false" hint="Executes around any event in this handler">
		<cfargument name="event">
		<cfargument name="targetAction" 	hint="The intercepted action UDF method"/>
		<cfargument name="eventArguments" 	hint="The event arguments an event is executed with (if any)"/>
		<cfscript>
			var rc = event.getCollection();
			// process targeted action
			argument.targetAction(event);
		</cfscript>
	</cffunction>
	
	
</cfcomponent>