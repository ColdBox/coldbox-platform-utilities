<!-----------------------------------------------------------------------
Author 	 :	Sana Ullah
Date     :	August 1, 2009
Description :
---------------------------------------------------------------------->
<cflog file="ColdBoxCFBuilder" text="Executing PluginSetup.cfm #timeFormat(now())#">
<cftry>

<cfparam name="ideeventinfo"> 
<cfset data = xmlParse(ideeventinfo)>
<cfset pluginDescription = "I am the new ColdBox Plugin" />

<cfheader name="Content-Type" value="text/xml">  
<cfoutput>  
<response status="success" type="default">  
	<ide handlerfile="PluginGenerator.cfm"> 
		<dialog width="450" height="450">  
			<input name="Name" lable="Enter plugin name"  type="string" default="" tooltip="Enter plugin cfc name without .cfc" />
			<input name="Version" lable="Enter plugin version"  type="string" default="" tooltip="Enter plugin version" />
			<input name="Description" lable="Enter plugin description"  type="string" default="" tooltip="Enter plugin description" />
			<input name="Author" lable="Enter plugin Author"  type="string" default="" tooltip="Enter plugin Author" />
			<input name="AuthorURL" lable="Enter plugin Author Url"  type="string" default="" tooltip="Enter plugin Author website URL" />
			
			<input name="Cache" Lable="Select Pluging cache strategy" type="list">
				<option value="true" />
				<option value="false" />
			</input>					
		</dialog>
	</ide>
</response>  
</cfoutput>

<cfcatch type="any">
	<cflog file="ColdBoxCFBuilder" text="#cfcatch.message#">
</cfcatch>
</cftry>


 