<!-----------------------------------------------------------------------
********************************************************************************
Copyright Since 2005 ColdBox Framework by Luis Majano and Ortus Solutions, Corp
www.coldboxframework.com | www.luismajano.com | www.ortussolutions.com
********************************************************************************

Author      :	Sana Ullah & Luis Majano

All handlers receive the following:
- data 		  : The data parsed
- inputStruct : A parsed input structure
----------------------------------------------------------------------->
<cfscript>
	entityName = listFirst( getFileFromPath(data.event.ide.projectview.resource.XMLAttributes.path), ".");
</cfscript>
<cfheader name="Content-Type" value="text/xml">  
<cfoutput>  
<response status="success" type="default">  
	<ide handlerfile="CrudGenerator.cfm"> 
		<dialog width="700" height="550" title="ColdBox CRUD Wizard" image="includes/images/ColdBox_Icon.png">  
			
			<input name="Name" label="Entity Name" required="true"  type="string" 
				   default="#entityName#" 
				   tooltip="The name of the Entity to create the CRUD for"
				   helpmessage="The name of the Entity to create the CRUD for" />
			
			<input name="PluralName" label="Entity Plural Name" required="true"  type="string" 
				  default="#entityName#s" 
				   tooltip="The plural name of the entity to manage for display purposes"
				   helpmessage="The plural name of the entity to manage for display purposes" />
		
			<input name="HandlersDirectory" label="Handlers Directory" type="projectdir" 
				   default="#data.event.ide.projectview.xmlattributes.projectlocation#/handlers" 
				   helpmessage="Your handlers root directory"
				   tooltip="Your handlers root directory" />
			
			<input name="ViewsDirectory" label="Views Directory" type="projectdir" 
				   default="#data.event.ide.projectview.xmlattributes.projectlocation#/views" 
				   helpmessage="Your views root directory"
				   tooltip="Your views root directory" />
			
		</dialog>
	</ide>
</response>  
</cfoutput>

 