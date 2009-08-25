<!-----------------------------------------------------------------------
Author 	 :	Sana Ullah
Date     :	August 1, 2009
Description :
---------------------------------------------------------------------->
<cftry>
<cfset data = xmlParse(ideeventinfo)>

<cfheader name="Content-Type" value="text/xml">  
<cfoutput>  
<response status="success" type="default">  
	<ide handlerfile="PluginGenerator.cfm"> 
		<dialog width="450" height="450" title="ColdBox Plugin Wizard">  
			<input name="Name" label="Enter plugin name" required="true"  type="string" default="" tooltip="Enter plugin cfc name without .cfc" />
			<input name="Version" label="Enter plugin version"  type="string" default="1.0" tooltip="Enter plugin version" />
			<input name="Description" label="Enter plugin description"  type="string" default="" tooltip="Enter plugin description" />
			<input name="Author" label="Enter plugin Author"  type="string" default="" tooltip="Enter plugin Author" />
			<input name="AuthorURL" label="Enter plugin Author Url"  type="string" default="" tooltip="Enter plugin Author website URL" />
			
			<input name="Cache" label="Cache this plugin" type="list" default="true">
				<option value="true" />
				<option value="false" />
			</input>	
			<input name="CacheTimeout" label="Minutes to persist (0=forever)" type="string" default="" />
		</dialog>
	</ide>
</response>  
</cfoutput>

<cfcatch type="any">
	<cflog file="ColdBoxCFBuilder" text="#cfcatch.message#">
</cfcatch>
</cftry>


 