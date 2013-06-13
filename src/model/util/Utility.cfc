<cfcomponent output="false">
<cfscript>

	function entityPropertyToStruct(str){
		var x =1;
		var map = {};
		var propertyList = "";

		arguments.str = REReplaceNoCase(arguments.str,"(cf)?property","");
		arguments.str = REReplaceNoCase(arguments.str," {2,}"," ");

		propertyList = listToArray(arguments.str," ");

		for(x=1; x lte arrayLen(propertyList);x++){
			map[ getToken( propertyList[x], 1, "=") ] = reREplace( getToken( propertyList[x], 2, "="), "'|#chr(34)#","","all");
		}

		// add defaults to it
		if( NOT structKeyExists(map,"fieldType") ){ map.fieldType = "column"; }
		if( NOT structKeyExists(map,"persistent") ){ map.persistent = true; }
		if( NOT structKeyExists(map,"formula") ){ map.formula = ""; }
		if( NOT structKeyExists(map,"readonly") ){ map.readonly = false; }

		// Add column isValid depending if it is persistable
		map.isPersistable = true;
		if( NOT map.persistent OR len(map.formula) OR map.readonly ){
			map.isPersistable = false;
		}

		return map;
	}

	function getInjectionDSLArray(){
		var injectionDSL = [
		"ioc","ocm","model","webservice","coldbox","coldbox:setting:","coldbox:plugin",
		"coldbox:myplugin","coldbox:datasource","coldbox:configBean","coldbox:mailSettingsBean",
		"coldbox:loaderService","coldbox:requestService","coldbox:debuggerService",
		"coldbox:pluginService","coldbox:handlerService","coldbox:moduleService",
		"coldbox:moduleSettings:","coldbox:moduleConfig:","coldbox:flash",
		"coldbox:interceptor","coldbox:cacheManager","coldbox:fwConfigBean","coldbox:fwSetting:",
		"coldbox:validationManager",
		"entityService","javaLoader","logBox","logBox:root","logBox:logger:","id",
		"provider",
		"wirebox","wirebox:parent","wirebox:eventmanager","wirebox:binder","wirebox:populator","wirebox:properties","wirebox:scope:","wirebox:property:",
		"cachebox"
		];
		arraySort(injectionDSL,"textnocase");
		return injectionDSL;
	}

	function capFirstLetter(str){
		return rereplace(lcase(arguments.str), "(\b\w)", "\u\1", "all");
	}

	function isNewVersion(cVersion,nVersion){
		var cMajor 		= getToken(arguments.cVersion,1,".");
		var cMinor		= getToken(arguments.cVersion,2,".");
		var cRevision	= getToken(arguments.cVersion,3,".");
		// new version info
		var nMajor 		= getToken(arguments.nVersion,1,".");
		var nMinor		= getToken(arguments.nVersion,2,".");
		var nRevision	= getToken(arguments.nVersion,3,".");

		// Major check
		if( nMajor gt cMajor ){
			return true;
		}

		// Minor Check
		if( nMajor eq cMajor AND nMinor gt cMinor ){
			return true;
		}

		// Revision Check
		if( nMajor eq cMajor AND nMinor eq cMinor AND nRevision gt cRevision){
			return true;
		}

		return false;
	}
</cfscript>

	<cffunction name="getURLBasePath" output="false" >
		<cfset var scriptPath = CGI.script_name>
		<cfset var javaStrObj = createObject("java", "java.lang.String").init(scriptPath)>
		<cfset var index = javaStrObj.lastIndexOf("/")>

		<cfset scriptPath = javaStrObj.subString(0,index)>

		<cfreturn "http://"&#CGI.SERVER_NAME# &":" &#CGI.SERVER_PORT# & scriptPath>
    </cffunction>

	<!---
	@author Topper (topper@cftopper.com)
	--->
	<cffunction name="getCurrentURL" output="No" access="public" returnType="string">
		<cfargument name="removeTemplate" type="boolean" required="false" default="false"/>

	    <cfset var theURL = getPageContext().getRequest().GetRequestUrl().toString()>
	    <cfif len( CGI.query_string )><cfset theURL = theURL & "?" & CGI.query_string></cfif>
	    <!--- Hack by Raymond, remove any CFID CFTOKEN --->
		<cfset theUrl = reReplaceNoCase(theUrl, "[&?]*cfid=[0-9]+", "")>
		<cfset theUrl = reReplaceNoCase(theUrl, "[&?]*cftoken=[^&]+", "")>

	    <!--- LM: If currentTemplate --->
		<cfif removeTemplate>
			<cfset theURL = replaceNoCase(theURL, getFileFromPath(theURL), "")>
		</cfif>

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

	<!---
	@author Joe Rinehart (joe.rinehart@gmail.com)
	--->
	<cffunction name="directoryCopy" output="true" hint="copy a directory" returntype="void">
	    <cfargument name="source" 		required="true" type="string">
	    <cfargument name="destination" 	required="true" type="string">

	    <cfset var contents = "" />

	    <cfif not(directoryExists(arguments.destination))>
	        <cfdirectory action="create" directory="#arguments.destination#">
	    </cfif>

	    <cfdirectory action="list" directory="#arguments.source#" name="contents">

	    <cfloop query="contents">
	        <cfif contents.type eq "file">
	            <cffile action="copy" source="#arguments.source#/#name#" destination="#arguments.destination#/#name#">
	        <cfelseif contents.type eq "dir">
	            <cfset directoryCopy(arguments.source & "/" & name, arguments.destination & "/" & name) />
	        </cfif>
	    </cfloop>
	</cffunction>

	<!--- throw it --->
	<cffunction name="throwit" access="public" hint="Facade for cfthrow" output="false">
		<cfargument name="message" 	required="true">
		<cfargument name="detail" 	required="false" default="">
		<cfargument name="type"  	required="false" default="Framework">
		<cfthrow type="#arguments.type#" message="#arguments.message#"  detail="#arguments.detail#">
	</cffunction>

	<!--- rethrowit --->
	<cffunction name="rethrowit" access="public" returntype="void" hint="Rethrow an exception" output="false" >
		<cfargument name="throwObject" required="true" hint="The exception object">
		<cfthrow object="#arguments.throwObject#">
	</cffunction>

	<!--- dump it --->
	<cffunction name="dumpit" access="public" hint="Facade for cfmx dump" returntype="void" output="true">
		<cfargument name="var" 		required="true">
		<cfargument name="isAbort"  type="boolean" default="false" required="false" hint="Abort also"/>
		<cfdump var="#var#"><cfif arguments.isAbort><cfabort></cfif>
	</cffunction>

	<!--- abort it --->
	<cffunction name="abortit" access="public" hint="Facade for cfabort" returntype="void" output="false">
		<cfabort>
	</cffunction>

</cfcomponent>