<!-----------------------------------------------------------------------
Author 	 :	Luis Majano
Date     :	3/12/2008
Description : 			
	An interface to bit.ly URL shortener, via json

Settings Needed

bitly_apiversion (optional) = The version of the api to use, defaults to 2.0.1
bitly_apilogin = The login to use
bitly_apikey = The api key to use

----------------------------------------------------------------------->
<cfcomponent hint="An interface to bit.ly URL shortener" 
			 extends="coldbox.system.plugin" 
			 output="false" 
			 cache="true">
  
<!------------------------------------------- CONSTRUCTOR ------------------------------------------->	
   
    <cffunction name="init" access="public" returntype="BitlyAPI" output="false">
		<cfargument name="controller" type="any" required="true">
		<cfscript>
	  		super.Init(arguments.controller);
	  		setpluginName("BitLy API");
	  		setpluginVersion("1.0");
	  		setpluginDescription("An interface to the Bitly API Shortener");
	  		
	  		//My own Constructor code here
	  		instance.apiVersion = "2.0.1";
	  		if( settingExists("bitly_apiversion") ){
	  			instance.apiVersion = getSetting("bitly_apiversion");
	  		}
	  		
	  		// Credentials
	  		instance.apilogin = getSetting("bitly_apilogin");
	  		instance.apikey = getSetting("bitly_apikey");
	  		instance.apiurl = "http://api.bit.ly";
	  		
	  		//Return instance
	  		return this;
		</cfscript>
	</cffunction>

<!------------------------------------------- PUBLIC ------------------------------------------->	

	<!--- shorten --->
	<cffunction name="shorten" output="false" access="public" returntype="struct" hint="Shorten the URL">
		<cfargument name="inURL" type="string" required="true" hint="The URL to shorten"/>
		<cfscript>
			var results = "";
			var params = {};
			
			params["longUrl"] = arguments.inURL;
			
			// Invoke call
			results = makeRequest(resource="shorten",parameters=params);
			
			// error 
			if( results.response.statusCode eq "ERROR" ){
				$throw("Error making REST Call",results.response.errorMessage);
			}
			
			return results.response.results[arguments.inURL];
		</cfscript>
	</cffunction>
	
	<!--- expand --->
	<cffunction name="expand" output="false" access="public" returntype="string" hint="Expand the URL">
		<cfargument name="inURL" type="string" required="true" hint="The URL to expand"/>
		<cfargument name="inUserHash" type="string" required="true" hint="The URL user hash"/>
		<cfscript>
			var results = "";
			var params = {};
			
			params["shortUrl"] = arguments.inURL;
			params["hash"] = arguments.inUserHash;
			
			// Invoke call
			results = makeRequest(resource="expand",parameters=params);
			
			// error 
			if( results.response.statusCode eq "ERROR" ){
				$throw("Error making REST Call",results.response.errorMessage);
			}
			
			return results.response.results[arguments.inUserHash].longURL;
		</cfscript>
	</cffunction>
	
    
<!------------------------------------------- PRIVATE ------------------------------------------->	

	<!--- makeRequest --->
    <cffunction name="makeRequest" output="false" access="private" returntype="struct" hint="Invoke a REST Call">
    	<cfargument name="method" 			type="string" 	required="false" default="GET" hint="The HTTP method to invoke"/>
		<cfargument name="resource" 		type="string" 	required="false" default="" hint="The resource to hit in the service."/>
		<cfargument name="body" 			type="any" 		required="false" default="" hint="The body content of the request if passed."/>
		<cfargument name="headers" 			type="struct" 	required="false" default="#structNew()#" hint="An struct of HTTP headers to send"/>
		<cfargument name="parameters"		type="struct" 	required="false" default="#structNew()#" hint="An struct of HTTP URL parameters to send in the request"/>
		<cfargument name="timeout" 			type="numeric" 	required="false" default="20" hint="The default call timeout"/>
		<cfscript>
			var results = {error=false,response={},message="",responseheader={},rawResponse=""};
			var HTTPResults = "";
			var param = "";
			var jsonRegex = "^(\{|\[)(.)*(\}|\])$";
			var endPoint = "#instance.apiURL#/#arguments.resource#?version=#instance.apiVersion#&login=#instance.apilogin#&apiKey=#instance.apiKey#&format=json";
			
			// Default Content Type
			if( NOT structKeyExists(arguments.headers,"content-type") ){
				arguments.headers["content-type"] = "";
			}
			
			// parameters
			for(param in arguments.parameters){
				endpoint = endpoint & "&#param#=#urlEncodedFormat(arguments.parameters[param])#";
			}
		</cfscript>
		<!--- REST CAll --->
		<cfhttp method="#arguments.method#" 
				url="#endpoint#" 
				charset="utf-8" 
				result="HTTPResults" 
				timeout="#arguments.timeout#">
			
			<!--- Headers --->
			<cfloop collection="#arguments.headers#" item="param">
				<cfhttpparam type="header" name="#param#" value="#arguments.headers[param]#" >
			</cfloop>	
			
			<!--- Body --->
			<cfif len(arguments.body) >
				<cfhttpparam type="body" value="#arguments.body#" >
			</cfif>	
		</cfhttp>
		<cfscript>
			// Log
			log.debug("Rest Call ->Arguments: #arguments.toString()#",HTTPResults);
			
			// Set Results
			results.responseHeader 	= HTTPResults.responseHeader;
			results.rawResponse 	= HTTPResults.fileContent.toString();
			
			// Error Details found?
			results.message = HTTPResults.errorDetail;
			if( len(HTTPResults.errorDetail) ){ results.error = true; }
			
			// Try to inflate JSON
			results.response = getPlugin("JSON").decode(results.rawResponse);
			
			return results;
		</cfscript>	
	</cffunction>
	
</cfcomponent>