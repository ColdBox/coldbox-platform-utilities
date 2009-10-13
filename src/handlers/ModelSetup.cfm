<!-----------------------------------------------------------------------
Author 	 :	Sana Ullah
Date     :	August 1, 2009
Description :
---------------------------------------------------------------------->
<cftry>
<cfset data = xmlParse(ideeventinfo)>
<cfset pluginDescription = "I am a new ColdBox Model" />

<cfheader name="Content-Type" value="text/xml">  
<cfoutput>  
<response status="success" type="default">  
	<ide handlerfile="ModelGenerator.cfm"> 
		<dialog width="500" height="450" title="New ColdBox Model Wizard" image="images/ColdBox_Icon.png">  
			
			<input name="Name" required="true" label="Model Name"  type="string" default="" 
				   tooltip="Enter model cfc name without .cfc"
				   helpmessage="Enter model cfc name without .cfc" />
				   
			<input name="Description" label="Description"  type="string" default="" 
				   tooltip="Enter model object description"
				   helpmessage="Enter model object description for hints" />
			
			<input name="Script" label="Script Based CFC" type="boolean" checked="false" tooltip="Choose whether to create the cfc in pure script or not." />
			
			<input name="Persistence" label="Persistence Type" type="list" default="Singleton">
				<option value="Transient" />
				<option value="Time Persisted" />
				<option value="Singleton" />
			</input>	
			<input name="CacheTimeout" label="Minutes to persist" type="string" default="" pattern="[0-9]+"
			       errormessage="Numeric values only."
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


 