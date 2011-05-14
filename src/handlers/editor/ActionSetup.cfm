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
<cfscript>
	projectLocation = data.event.ide.editor.file.XMLAttributes.projectLocation;
	handler = listFirst( data.event.ide.editor.file.XMLAttributes.name, "." );
</cfscript>

<cfheader name="Content-Type" value="text/xml">  
<cfoutput>  
<response status="success" type="default">  
	<ide handlerfile="editor/ActionGenerator.cfm"> 
		<dialog width="700" height="400" title="ColdBox Action Wizard" image="includes/images/ColdBox_Icon.png">  
			
			<input name="Name" label="Method Name" required="true"  type="string" default="" 
				   tooltip="Enter the name of the action to create"
				   helpmessage="Enter the name of the action to create" />
		
			<input name="Script" label="Script Based CFC" type="boolean" checked="true" 
				   tooltip="Choose whether to create the cfc in pure script or not."
				   helpmessage="Choose whether to create the cfc in pure script or not." />
			
			<input name="GenerateViews" label="Generate View(s)" type="boolean" checked="true" 
				   helpmessage="Generate views according to action"
				   tooltip="Generate views according to action" />
				   
			<input name="ViewsDirectory" label="Views Directory" type="projectdir" 
				   default="#projectLocation#/views/#handler#" 
				   helpmessage="Your views root directory"
				   tooltip="Your views root directory" />
			
		</dialog>
	</ide>
</response>  
</cfoutput>

 