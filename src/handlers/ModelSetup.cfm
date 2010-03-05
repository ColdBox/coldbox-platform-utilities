<!-----------------------------------------------------------------------
********************************************************************************
Copyright Since 2005 ColdBox Framework by Luis Majano and Ortus Solutions, Corp
www.coldboxframework.com | www.luismajano.com | www.ortussolutions.com
********************************************************************************

Author      :	Sana Ullah & Luis Majano
Date        :	08/01/2009

All handlers receive the following:
- data 		  : The data parsed
- inputStruct : A parsed input structure
----------------------------------------------------------------------->

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
			<input name="CacheTimeout" label="Minutes to persist (Time Persisted Only)" type="string" default="" pattern="[0-9]+"
			       errormessage="Numeric values only."
				   helpmessage="Minutes to persist if using Time Persisted type."
				   tooltip="Minutes to persist if using Time Persisted type."/>
		</dialog>
	</ide>
</response>  
</cfoutput>

 