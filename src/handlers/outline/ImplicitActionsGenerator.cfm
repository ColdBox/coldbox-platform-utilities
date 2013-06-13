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
// action name
action = controller.getUtility().capFirstLetter(data.event.ide.outlineView.source.node.function.XMLAttributes.name);
// file location
filePath = data.event.ide.outlineView.source.XMLAttributes.path;
// read CFC
contents = fileRead(filePath);
// script buffer
buffer = createObject("java","java.lang.StringBuffer").init('');
//if tags?
if( NOT inputStruct.script ){
	if( inputStruct.preHandler ){
	buffer.append('
	<cffunction name="pre#action#" returntype="void" output="false" hint="Executes before the #action# method action">
		<cfargument name="event">
		<cfargument name="rc">
		<cfargument name="prc">
		<cfargument name="eventArguments" hint="The event arguments an event is executed with (if any)"/>
		<cfscript>
			
		</cfscript>
	</cffunction>
	');
	}
	if( inputStruct.postHandler ){
	buffer.append('
	<cffunction name="post#action#" returntype="void" output="false" hint="Executes after the #action# method action">
		<cfargument name="event">
		<cfargument name="action" 			hint="The intercepted action"/>
		<cfargument name="rc">
		<cfargument name="prc">
		<cfargument name="eventArguments" 	hint="The event arguments an event is executed with (if any)"/>
		<cfscript>
		
		</cfscript>
	</cffunction>
	');
	}
	if( inputStruct.aroundHandler ){
	buffer.append('
	<cffunction name="around#action#" returntype="void" output="false" hint="Executes around the #action# method action">
		<cfargument name="event">
		<cfargument name="rc">
		<cfargument name="prc">
		<cfargument name="targetAction" 	hint="The intercepted action UDF method"/>
		<cfargument name="eventArguments" 	hint="The event arguments an event is executed with (if any)"/>
		<cfscript>
		
			// process targeted action
			var results = argument.targetAction(event,rc,prc);
			
			if( !isNull( results ) ){ return results; }
		</cfscript>
	</cffunction>
	');
	}
	buffer.append("
</cfcomponent>");
	contents = replaceNoCase(contents,"</cfcomponent>",buffer.toString());
}
else{
	if( inputStruct.preHandler ){
	buffer.append('
	function pre#action#(event,rc,prc,action,eventArguments){

	}
	');
	}
	if( inputStruct.postHandler ){
	buffer.append('
	function post#action#(event,rc,prc,action,eventArguments){

	}
	');
	}
	if( inputStruct.aroundHandler ){
	buffer.append('
	function around#action#(event,rc,prc,targetAction,eventArguments){

		// executed targeted action
		var results = arguments.targetAction(event,rc,prc);
		
		if( !isNull( results ) ){ return results; }
	}
	');
	}
	buffer.append("
}");
	contents = reReplace(contents,"\}[^\}\}]*$",buffer.toString());
}

// Render out file
fileWrite(filePath, contents);
</cfscript>

<!--- Display --->
<cfheader name="Content-Type" value="text/xml">
<cfoutput>
<response status="success" showresponse="true">
<ide>
	<commands>
        <command type="refreshfile">
        <params>
	        <param key="filename" value="#filePath#" />
        </params>
        </command>
    </commands>
	<dialog width="550" height="350" title="ColdBox Implicit Actions Wizard" image="includes/images/ColdBox_Icon.png"/>
	<body><![CDATA[
	<html>
		<head>
			<base href="#controller.getBaseURL()#" />
			<link href="includes/css/styles.css" type="text/css" rel="stylesheet">
			<script type="text/javascript" src="includes/js/jquery.latest.min.js"></script>
		</head>
		<body>
			<div class="messagebox-green">Generated Implicit Actions!</div>
			<p>
			The generated methods have been placed at the bottom of the CFC
			</p>
		</body>
	</html>
	]]></body>
</ide>
</response>
</cfoutput>