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
		<dialog width="600" height="450" title="ColdBox Plugin Wizard" image="images/ColdBox_Icon.png">  
			<input name="Name" label="Plugin Name" required="true"  type="string" default="" tooltip="Enter plugin cfc name without .cfc" />
			<input name="Script" label="Script Based CFC" type="boolean" checked="false" tooltip="Choose whether to create the cfc in pure script or not." />
			<input name="Version" label="Plugin version"  type="string" default="1.0" tooltip="Enter plugin version" />
			<input name="Description" label="Plugin description"  type="string" default="" tooltip="Enter plugin description" />
			<input name="Author" label="Plugin Author"  type="string" default="" tooltip="Enter plugin Author" />
			<input name="AuthorURL" label="Plugin Author Url"  type="string" default="" tooltip="Enter plugin Author website URL" />
			
			<input name="Persistence" label="Persistence Type" type="list" default="Time Persisted">
				<option value="Transient" />
				<option value="Time Persisted" />
				<option value="Singleton" />
			</input>	
			<input name="CacheTimeout" label="Minutes to persist" type="string" default="" 
			       helpmessage="Minutes to persist if using Time Persisted type."
				   tooltip="Minutes to persist if using Time Persisted type."/>
		</dialog>
	</ide>
</response>  
</cfoutput>

<cfcatch type="any">
	<cflog file="ColdBoxCFBuilder" text="#cfcatch.message#">
</cfcatch>
</cftry>


 