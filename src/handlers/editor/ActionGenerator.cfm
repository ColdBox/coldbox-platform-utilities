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
	buffer.append('
	<!--- #inputStruct.name# --->
	<cffunction name="#inputStruct.name#" returntype="any" output="false">
		<cfargument name="event">
		<cfargument name="rc">
		<cfargument name="prc">
		<cfscript>
			
			
		</cfscript>
	</cffunction>
	');
}

// Create View
if( inputStruct.generateViews ){
	
	// directory exists?
	if( NOT directoryExists(inputStruct.viewsDirectory) ){
		controller.getUtility().createDirectory( inputStruct.viewsDirectory );
	}
		
	fileName = inputStruct.viewsDirectory & "/#inputStruct.name#.cfm";
	fileWrite( fileName , "<h1>View: #inputStruct.name#</h1>");
}
</cfscript>

<!--- Save Script Functions --->
<cfif inputStruct.script>
<cfsavecontent variable="scriptFunctions">
<cfoutput>
	/**
	* #inputStruct.name#
	*/
	function #inputStruct.name#(event,rc,prc){
	
	}
</cfoutput>
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