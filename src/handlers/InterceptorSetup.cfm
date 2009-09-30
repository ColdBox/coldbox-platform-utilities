<!-----------------------------------------------------------------------
Author 	 :	Sana Ullah
Date     :	August 1, 2009
Description :
---------------------------------------------------------------------->
<cftry>
<cfset data = xmlParse(ideeventinfo)>

<cfset Points = "afterConfigurationLoad,afterAspectsLoad,onException," &
		        "afterHandlerCreation,afterModelCreation,afterPluginCreation," &
				"sessionStart,sessionEnd," &
				"preProcess,preEvent,postEvent,postProcess," &
				"preLayout,preRender,postRender," &
				"afterCacheElementInsert,afterCacheElementRemoved,afterCacheElementExpired">

<cfheader name="Content-Type" value="text/xml">  
<cfoutput>  
<response>  
	<ide handlerfile="InterceptorGenerator.cfm"> 
		<dialog width="650" height="350" title="ColdBox Interceptor Wizard" image="images/ColdBox_Icon.png">  
			<input name="Name" label="Enter interceptor name" required="true"  type="string" default="" tooltip="Enter interceptor cfc name without .cfc" />
			<input name="Description" label="Enter interceptor description"  type="string" default="" tooltip="Enter interceptor description" />					
			<input name="Script" label="Script Based CFC" type="boolean" checked="false" tooltip="Choose whether to create the cfc in pure script or not." />
			<input name="InterceptionPoints" label="Create the following interception points" type="string" default="#points#" /> 
		</dialog>
	</ide>
</response>  
</cfoutput>

<cfcatch type="any">
	<cflog file="ColdBoxCFBuilder" text="#cfcatch.message#">
</cfcatch>
</cftry>


 