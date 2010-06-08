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
	<ide handlerfile="ORMEventHandlerGenerator.cfm"> 
		<dialog width="600" height="550" title="ColdBox ORM Event Handler Wizard" image="includes/images/ColdBox_Icon.png">  
		
			<input name="Name" label="Event Handler Name" required="true"  type="string" default="EventHandler" 
					tooltip="The name of your ORM Event Handler Object (no .cfc)" />
			<input name="Injector" label="Enable Entity DI" required="false" default="false"  type="boolean" 
					tooltip="Activate the entity dependency injector" />
			<input name="setterInjection" label="Enable Setter Injection" required="false" default="false"  type="boolean" 
					tooltip="Activate alongside annotation injection, setter injection" />
			<input name="StopRecursion" label="Stop Recursion Classes" required="false"  type="string" 
					tooltip="The list of classes to stop recursion on when looking for dependencies" />
			<input name="InjectorInclude" label="Injector Include Entity List" required="false"  type="string" 
					tooltip="A list of entity names to include for injection ONLY! If empty, all entities will be inspected for DI" />
			<input name="InjectorExclude" label="Injector Exclude Entity List" required="false"  type="string" 
					tooltip="A list of entity names to exclude for injection" />
		</dialog>
	</ide>
</response>  
</cfoutput>

 