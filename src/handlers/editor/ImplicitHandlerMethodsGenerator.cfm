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
<cfscript>
//if tags?
if( NOT inputStruct.script ){
	buffer = createObject("java","java.lang.StringBuffer").init('');
	if( inputStruct.preHandler ){
	buffer.append('
	<cffunction name="preHandler" returntype="void" output="false" hint="Executes before any event in this handler">
		<cfargument name="event">
		<cfargument name="action" hint="The intercepted action"/>
		<cfargument name="eventArguments" hint="The event arguments an event is executed with (if any)"/>
		<cfargument name="rc">
		<cfargument name="prc">
		<cfscript>

		</cfscript>
	</cffunction>
	');
	}
	if( inputStruct.postHandler ){
	buffer.append('
	<cffunction name="postHandler" returntype="void" output="false" hint="Executes after any event in this handler">
		<cfargument name="event">
		<cfargument name="action" 			hint="The intercepted action"/>
		<cfargument name="eventArguments" 	hint="The event arguments an event is executed with (if any)"/>
		<cfargument name="rc">
		<cfargument name="prc">
		<cfscript>

		</cfscript>
	</cffunction>
	');
	}
	if( inputStruct.aroundHandler ){
	buffer.append('
	<cffunction name="aroundHandler" returntype="void" output="false" hint="Executes around any event in this handler">
		<cfargument name="event">
		<cfargument name="targetAction" 	hint="The intercepted action UDF method"/>
		<cfargument name="eventArguments" 	hint="The event arguments an event is executed with (if any)"/>
		<cfargument name="rc">
		<cfargument name="prc">
		<cfscript>

			// process targeted action
			var results = argument.targetAction(event,rc,prc);
			
			if( !isNull( results ) ){ return results; }
		</cfscript>
	</cffunction>
	');
	}
	if( inputStruct.onMissingAction ){
	buffer.append('
	<cffunction name="onMissingAction" returntype="void" output="false" hint="Executes if a request action (method) is not found in this handler">
		<cfargument name="event" >
		<cfargument name="missingAction" 	hint="The requested action string"/>
		<cfargument name="eventArguments" 	hint="The event arguments an event is executed with (if any)"/>
		<cfargument name="rc">
		<cfargument name="prc">
		<cfscript>

		</cfscript>
	</cffunction>
	');
	}
	if( inputStruct.onError ){
	buffer.append('
	<cffunction name="onError" output="false" hint="Executes if ANY action causes an exception">
		<cfargument name="event">
		<cfargument name="faultAction" 		hint="The action that caused the error"/>
		<cfargument name="exception"  		hint="The exception structure"/>
		<cfargument name="eventArguments" 	hint="The event arguments an event is executed with (if any)"/>
		<cfargument name="rc">
		<cfargument name="prc">
		<cfscript>	
			
		</cfscript>
	</cffunction>
	');
	}
}
</cfscript>

<!--- Save Script Functions --->
<cfif inputStruct.script>
<cfsavecontent variable="scriptFunctions">
	<cfif inputStruct.preHandler>
	function preHandler(event,action,eventArguments,rc,prc){

	}
	</cfif>
	<cfif inputStruct.postHandler>
	function postHandler(event,action,eventArguments,rc,prc){

	}
	</cfif>
	<cfif inputStruct.aroundHandler>
	function aroundHandler(event,targetAction,eventArguments,rc,prc){

		// executed targeted action
		var results = arguments.targetAction(event,rc,prc);
		
		if( !isNull( results ) ){ return results; }
	}
	</cfif>
	<cfif inputStruct.onMissingAction>
	function onMissingAction(event,missingAction,eventArguments,rc,prc){

	}
	</cfif>
	<cfif inputStruct.onError>
	function onError(event,faultAction,exception,eventArguments,rc,prc){

	}
	</cfif>
</cfsavecontent>
</cfif>

<!--- Display --->
<cfheader name="Content-Type" value="text/xml">  
<cfoutput>
<response status="success" showresponse="true">  
<ide>  
	<commands> 
		<command type="inserttext"> 
			<params> 
				<param key="text" > 
				<![CDATA[ 
<cfif inputStruct.Script>#scriptFunctions#<cfelse>#buffer.toString()#</cfif>
				 ]]> 
				</param> 
			</params> 
		</command> 
	</commands> 
</ide>
</response>
</cfoutput>