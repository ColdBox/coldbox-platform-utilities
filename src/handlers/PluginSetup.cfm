<!-----------------------------------------------------------------------
Author 	 :	Sana Ullah
Date     :	August 1, 2009
Description :
---------------------------------------------------------------------->
<cflog file="ColdBoxCFBuilder" text="Executing PluginSetup.cfm #timeFormat(now())#">
<cftry>

<cfparam name="ideeventinfo"> 
<cfset data = xmlParse(ideeventinfo)>

<cfheader name="Content-Type" value="text/xml">  
<cfoutput>  
<response status="success" type="default">  
	<ide handlerfile="PluginGenerator.cfm"> 
		<dialog width="450" height="450">  
			<input name="PluginName" Lable="Enter plugin name"  type="string" default="" tooltip="Enter plugin cfc name without .cfc" />					
		</dialog>
	</ide>
</response>  
</cfoutput>

<cfcatch type="any">
	<cflog file="ColdBoxCFBuilder" text="#cfcatch.message#">
</cfcatch>
</cftry>


 