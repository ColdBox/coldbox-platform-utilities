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
		<dialog width="450" height="450" title="New ColdBox Model Wizard" image="images/ColdBox_Icon.png">  
			<input name="Name" required="true" label="Enter model object name"  type="string" default="" tooltip="Enter model cfc name without .cfc" />
			<input name="Description" label="Enter model object description"  type="string" default="" tooltip="Enter model object description" />
			<input name="Singleton" label="Singleton" type="Boolean" checked="false" tooltip="Select if the object is a singleton" />
			
			<input name="Cache" label="Time Persisted Object" tooltip="Select if you want the object to be time persisted" type="Boolean" checked="false" />
			<input name="CacheTimeout" label="Minutes to persist" type="string" default="" />
		</dialog>
	</ide>
</response>  
</cfoutput>

<cfcatch type="any">
	<cflog file="ColdBoxCFBuilder" text="#cfcatch.message#">
</cfcatch>
</cftry>


 