<cfcomponent output="false" hint="Extension Controller">

	<!--- init --->
    <cffunction name="init" output="false" access="public" returntype="any" hint="Constructor">
    	<cfargument name="data">
    	<cfscript>
    		utility = createObject("component","coldboxExtension.model.util.Utility");
			
			variables.data = arguments.data;
			
			return this;
		</cfscript>
    </cffunction>
    
    <!--- getCallBackURL --->    
    <cffunction name="getCallBackURL" output="false" access="public" returntype="any" hint="">    
    	<cfscript>
			if( NOT structIsEmpty(data) AND structKeyExists(data.event.ide,"callbackURL")){
				return data.event.ide.callbackURL.XMLText;
			}
			return "";
		</cfscript>	
    </cffunction>
    
    <!--- sendCommand --->    
    <cffunction name="sendCommand" output="false" access="public" returntype="any" hint="">    
    	<cfargument name="xml" 		type="any" required="true"/>
		<cfargument name="callBack" type="any" required="false" default="#getCallBackURL()#"/>
		<cfset var commandresponse = "">
		
		<cfhttp method="post" url="#arguments.callBack#" result="commandresponse" > 
		    <cfhttpparam type="body" value="#arguments.xml#" > 
		</cfhttp>
		
		<cfreturn commandresponse>
	
    </cffunction>
    
    <!--- refreshProject --->    
    <cffunction name="refreshProject" output="false" access="public" returntype="any" hint="Refresh a project via command URL">    
    	<cfargument name="projectName">
		<cfargument name="callBackURL" type="any" required="false" default="#getCallBackURL()#"/>
			
		<cfset var commandXML = "">
		
		<!--- Project Refresh Command --->
		<cfsavecontent variable="commandXML">
		<cfoutput>
		<response> 
		<ide> 
		    <commands> 
		        <command type="refreshProject"> 
					 <params> 
					  	<param key="projectname" value="#arguments.projectName#" /> 
					 </params> 
					</command> 
		    </commands>     
		</ide> 
		</response> 
		</cfoutput> 	
		</cfsavecontent>
		
		<!--- Send Command --->
		<cfthread name="callbackCommandThread" commandXML="#commandXML#" callbackURL="#arguments.callBackURL#">
			<cfset sendCommand(attributes.commandXMl,attributes.callBackURL)>
		</cfthread>
    </cffunction>
    
    <!--- parseInput --->
    <cffunction name="parseInput" output="false" access="public" returntype="any" hint="Parse Input">
    	<cfargument name="eventData" type="any" required="true" />
    	<cfscript>
	    	var extXMLInput = "";
			var inputStruct = StructNew();
			var i = 1;
			
			/**
			if( isStruct(arguments.eventData) ){
				return inputStruct;
			}
			*/

			if( server.coldfusion.productname eq "Railo" and !isXML( arguments.eventData ) ){
				return inputStruct;
			}
			else if( server.coldfusion.productname neq "Railo" and isStruct( arguments.eventData ) ){
				return inputStruct;
			}
			
			extXMLInput = xmlSearch(arguments.eventData, "/event/user/input");
			
			for(i=1; i lte arrayLen(extXMLInput); i++){
				StructInsert(inputStruct,"#extXMLInput[i].xmlAttributes.name#","#extXMLInput[i].xmlAttributes.value#");	
			}
			
			return inputStruct;
		</cfscript>
    </cffunction>
	
	<!--- getProjectInfo --->    
    <cffunction name="getProjectInfo" output="false" access="public" returntype="any" hint="Get projectlocation and projectname in a struct">    
    	<cfscript>
			var p = {
				projectLocation = "", projectName = ""
			};
			if( structKeyExists(data.event.ide,"projectView") ){
				p = data.event.ide.projectView.XMLAttributes;
			}
			
			return p;
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
