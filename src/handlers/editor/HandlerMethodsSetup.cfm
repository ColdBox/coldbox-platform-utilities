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
	<ide handlerfile="HandlerGenerator.cfm"> 
		<dialog width="700" height="550" title="ColdBox Event Handler Wizard" image="includes/images/ColdBox_Icon.png">  
			
			<input name="Name" label="Handler Name" required="true"  type="string" default="" 
				   tooltip="Enter handler cfc name without .cfc"
				   helpmessage="Enter handler cfc name without .cfc" />
		
			<input name="Description" label="Description (Hint)"  type="string" default="" 
				   tooltip="Enter handler description"
				   helpmessage="Enter handler description" />					
			
			<input name="Script" label="Script Based CFC" type="boolean" checked="false" 
				   tooltip="Choose whether to create the cfc in pure script or not."
				   helpmessage="Choose whether to create the cfc in pure script or not." />
			
			<input name="Actions" label="Actions (comma delimmitted)" type="string" default="index" 
				   tooltip="Enter a list of actions to generate, can be separated by a comma"
				   helpmessage="Enter a list of actions to generate, can be separated by a comma"/>
			
			<input name="GenerateViews" label="Generate View(s)" type="boolean" 
				   helpmessage="Generate views according to actions"
				   tooltip="Generate views according to actions" />
				   
			<input name="ViewsDirectory" label="Views Directory" type="projectdir" 
				   default="#data.event.ide.projectview.xmlattributes.projectlocation#/views" 
				   helpmessage="Your views root directory"
				   tooltip="Your views root directory" />
			
			<input name="GenerateTest" label="Generate Integration Test" type="boolean" 
				   tooltip="Generate the integration test component"
				   helpmessage="Generate the integration test component" />
				   
			<input name="AppMapping" label="AppMapping" type="string" default="/"
				   tooltip="The root location of the application on the server: ex: /MyApp or / if in the root"
				   helpmessage="The root location of the application on the server: ex: /MyApp or / if in the root" />
				   
			<input name="TestsDirectory" label="Integration Tests Directory" type="projectdir" 
				   default="#data.event.ide.projectview.xmlattributes.projectlocation#/test/integration" 
				   tooltip="Your integration tests directory"
				   helpmessage="Your integration tests directory" />
			
		</dialog>
	</ide>
</response>  
</cfoutput>

 