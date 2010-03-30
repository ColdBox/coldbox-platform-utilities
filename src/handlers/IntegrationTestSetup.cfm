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
	<ide handlerfile="IntegrationTestGenerator.cfm"> 
		<dialog width="700" height="550" title="ColdBox Integration Test Wizard" image="includes/images/ColdBox_Icon.png">  
			
			<input name="Name" label="Name of Handler To Test" required="true"  type="string" default="" 
				   tooltip="Enter the name of the handler to test without .cfc"
				   helpmessage="Enter the name of the handler to test without .cfc" />
		
			<input name="Script" label="Script Based CFC" type="boolean" checked="false" 
				   tooltip="Choose whether to create the cfc in pure script or not."
				   helpmessage="Choose whether to create the cfc in pure script or not." />
			
			<input name="Actions" label="Actions To Test (comma delimmitted)" type="string" default="" 
				   tooltip="Enter a list of actions to generate tests for, can be separated by a comma"
				   helpmessage="Enter a list of actions to generate tests for, can be separated by a comma"/>
			
			<input name="AppMapping" label="AppMapping" type="string" default="/" required="true"
				   tooltip="The root location of the application on the server: ex: /MyApp or / if in the root"
				   helpmessage="The root location of the application on the server: ex: /MyApp or / if in the root" />
				   
		</dialog>
	</ide>
</response>  
</cfoutput>

 