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
// action name
action = controller.getUtility().capFirstLetter(data.event.ide.outlineView.source.node.function.XMLAttributes.name);
// file location
filePath = data.event.ide.outlineView.source.XMLAttributes.path;
// script
isTagBased = findNoCase("<cfcomponent", fileRead(filePath));
</cfscript>
<cfheader name="Content-Type" value="text/xml">  
<cfoutput>  
<response status="success" type="default">  
	<ide handlerfile="outline/ImplicitActionsGenerator.cfm"> 
		<dialog width="700" height="500" title="ColdBox Implicit Actions Wizard" image="includes/images/ColdBox_Icon.png">  
			
			<!--- Pre Handler --->
			<input name="preHandler" label="Generate pre#action#()" type="boolean" checked="false" 
				   tooltip="Generate a pre#action# action."
				   helpmessage="Generate a pre#action# action." />
			
			<!--- Post Handler --->
			<input name="postHandler" label="Generate post#action#()" type="boolean" checked="false" 
				   tooltip="Generate a post#action# action."
				   helpmessage="Generate a post#action# action." />
			
			<!--- Around Handler --->
			<input name="aroundHandler" label="Generate around#action#()" type="boolean" checked="false" 
				   tooltip="Generate a around#action# action."
				   helpmessage="Generate a around#action# action." />
			
			<!--- Script --->
			<input name="Script" label="Script Based Methods" type="boolean" checked="#NOT isTagBased#" 
				   tooltip="Choose whether to create the methods in pure script or not."
				   helpmessage="Choose whether to create the methods in pure script or not." />
			
		</dialog>
	</ide>
</response>  
</cfoutput>

 