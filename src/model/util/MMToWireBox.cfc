<!-----------------------------------------------------------------------
********************************************************************************
Copyright 2005-2007 ColdBox Framework by Luis Majano and Ortus Solutions, Corp
www.coldboxframework.com | www.luismajano.com | www.ortussolutions.com
********************************************************************************

Model Mapping Converter to WireBox

----------------------------------------------------------------------->
<cfcomponent output="false" hint="CS Converter to WireBox">

	<cffunction name="init" access="public" returnType="MMToWireBox" output="false" hint="Constructor">
		<cfscript>
			return this;
		</cfscript>
	</cffunction>
	
	<!--- convert --->
	<cffunction name="convert" access="public" returntype="struct" hint="Convert to WireBox" output="false" >
		<cfargument name="filePath"	required="true">
		<cfscript>
			var results = {
				errorMessages = "",
				data = ""
			};
			var local = {};
			// regex for non-greedy match of the first <cfscript> tag contents
			local.scriptContentsRegex = ".*?<cfscript>(.*?)<\/cfscript>.*";
			// regex to match calls to addModelMapping()
			local.MMToWBRegex = "addModelMapping\s*\(\s*(alias\s*=\s*)?([^;]*?)\s*,\s*(path\s*=\s*)?\s*([^;]*?)\s*\)\s*";
			
			// Parsing
			try{
				local.mmCFML = fileRead(arguments.filePath);

				// Extract the contents of the first cfscript tag.
				// If important logic was included outside these tags, this won't work too well.
				results.data = reReplaceNoCase(local.mmCFML,local.scriptContentsRegex,"\1","ONE");
				
				// Replace wach addModelMapping() call with map().to()
		 		results.data = reReplaceNoCase(results.data,local.MMToWBRegex,"map(\2).to(\4)","ALL");
 		
			}
			catch(any e){
				results.errorMessages = "Error parsing model mappings: #e.message# #e.detail# #e.stacktrace#";
			}
			
			return results;
		</cfscript>
	</cffunction>
	
	<!--- getUtil --->
	<cffunction name="getUtil" output="false" access="private" returntype="any" hint="Get the utility object">
		<cfreturn createObject("component","coldboxExtension.model.util.Utility")>
	</cffunction>

</cfcomponent>
