<cfcomponent output="false">

	<!---
	Returns the current URL for the page.
	@return Returns a string.
	@author Topper (topper@cftopper.com)
	@version 1, September 5, 2008
	--->
	<cffunction name="getCurrentURL" output="No" access="public" returnType="string">
	    <cfset var theURL = getPageContext().getRequest().GetRequestUrl().toString()>
	    <cfif len( CGI.query_string )><cfset theURL = theURL & "?" & CGI.query_string></cfif>
	    <!--- Hack by Raymond, remove any CFID CFTOKEN --->
		<cfset theUrl = reReplaceNoCase(theUrl, "[&?]*cfid=[0-9]+", "")>
		<cfset theUrl = reReplaceNoCase(theUrl, "[&?]*cftoken=[^&]+", "")>
	    <cfreturn theURL>
	</cffunction>
	
	<!--- prettifyXML --->
    <cffunction name="prettifyXML" output="false" access="public" returntype="any" hint="prettify xml">
    	<cfargument name="inXML" type="any" required="true" default="" hint="The xml document to prettify"/>
    	<cfscript>
    		var formatterPath = getDirectoryFromPath(getMetadata(this).path) & "/xmlFormatter.xsl"; 
			
    		return xmlTransform(toString(arguments.inXML),FileRead(formatterPath));
    	</cfscript>
    </cffunction>
	
	<!--- createDirectory --->
    <cffunction name="createDirectory" output="false" access="public" returntype="void" hint="">
    	<cfargument name="path" type="string" required="true" />
    	<cfdirectory action="create" directory="#arguments.path#">
    </cffunction>
	
	<!--- parseInput --->
    <cffunction name="parseInput" output="false" access="public" returntype="any" hint="Parse Input">
    	<cfargument name="eventData" type="any" required="true" />
    	<cfscript>
	    	var extXMLInput = xmlSearch(arguments.eventData, "/event/user/input");
			var inputStruct = StructNew();
			var i = 1;
			
			for(i=1; i lte arrayLen(extXMLInput); i++){
				StructInsert(inputStruct,"#extXMLInput[i].xmlAttributes.name#","#extXMLInput[i].xmlAttributes.value#");	
			}
			
			return inputStruct;
		</cfscript>
    </cffunction>
	
	<!---
	Copies a directory.
	
	@param source      Source directory. (Required)
	@param destination      Destination directory. (Required)
	@param nameConflict      What to do when a conflict occurs (skip, overwrite, makeunique). Defaults to overwrite. (Optional)
	@return Returns nothing. 
	@author Joe Rinehart (joe.rinehart@gmail.com) 
	@version 2, February 4, 2010 
	--->
	<cffunction name="directoryCopy" output="true">
	    <cfargument name="source" 		required="true" type="string">
	    <cfargument name="destination" 	required="true" type="string">
	    <cfargument name="nameconflict" required="true" default="overwrite">
	
	    <cfset var contents = "" />
	    
	    <cfif not(directoryExists(arguments.destination))>
	        <cfdirectory action="create" directory="#arguments.destination#">
	    </cfif>
	    
	    <cfdirectory action="list" directory="#arguments.source#" name="contents">
	    
	    <cfloop query="contents">
	        <cfif contents.type eq "file">
	            <cffile action="copy" source="#arguments.source#/#name#" destination="#arguments.destination#/#name#" nameconflict="#arguments.nameConflict#">
	        <cfelseif contents.type eq "dir">
	            <cfset directoryCopy(arguments.source & "/" & name, arguments.destination & "/" & name, arguments.nameconflict) />
	        </cfif>
	    </cfloop>
	</cffunction>

	
</cfcomponent>