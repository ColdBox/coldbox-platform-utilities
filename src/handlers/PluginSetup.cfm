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
	<ide handlerfile="PluginGenerator.cfm"> 
		<dialog width="700" height="550" title="ColdBox Plugin Wizard" image="includes/images/ColdBox_Icon.png">  
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
			<input name="CacheTimeout" label="Timeout (Time Persisted Only)" type="string" default="" pattern="[0-9]+"
			       errormessage="Numeric values only."
				   helpmessage="Minutes to persist if using Time Persisted type."
				   tooltip="Minutes to persist if using Time Persisted type."/>
			
			<input name="GenerateTest" label="Generate Unit Test" type="boolean" 
				   tooltip="Generate the unit test component"
				   helpmessage="Generate the unit test component" />
			
			<input name="TestsDirectory" label="Unit Tests Directory" type="projectdir" 
				   default="#data.event.ide.projectview.xmlattributes.projectlocation#/test/unit" 
				   tooltip="Your unit tests directory"
				   helpmessage="Your unit tests directory" />
		</dialog>
	</ide>
</response>  
</cfoutput>

 