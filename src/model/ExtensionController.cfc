<cfcomponent output="false" hint="Extension Controller">

	<!--- init --->
    <cffunction name="init" output="false" access="public" returntype="any" hint="Constructor">
    	<cfscript>
    		utility = createObject("component","coldboxExtension.model.util.Utility");
		
			return this;
		</cfscript>
    </cffunction>
	
	<!--- getUtility --->
    <cffunction name="getUtility" output="false" access="public" returntype="any" hint="Get the utility object">
    	<cfreturn utility>
    </cffunction>
	
	<!--- getExtensionLocation --->
    <cffunction name="getExtensionLocation" output="false" access="public" returntype="any" hint="Get the extension location">
    	<cfreturn expandPath("/coldboxExtension")>
    </cffunction>
	
	<!--- getBaseURL --->
    <cffunction name="getBaseURL" output="false" access="public" returntype="any" hint="Get the request's base URL cleaned up">
    	<cfscript>
    		return replaceNoCase( utility.getURLBasePath(),"handlers","");
		</cfscript>
    </cffunction>





</cfcomponent>
