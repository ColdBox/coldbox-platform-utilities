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
	<ide handlerfile="orm/TemplatedEntityServiceGenerator.cfm"> 
		<dialog width="600" height="350" title="ColdBox Templated Entity Service Wizard" image="includes/images/ColdBox_Icon.png">  
			<input name="ServiceName" label="Service Name" required="true" default="Service"  type="string" tooltip="The name of service to build" />
			<input name="QueryCaching" label="Use Query Caching" type="boolean" checked="false"  tooltip="Use query caching?" />
			<input name="EventHandling" label="Enable Event Handling" checked="true"  type="boolean" tooltip="Enables the templated service to announce ColdBox Interception ORM Events" />
			<input name="CacheRegion" label="Query Cache Region" required="false"  type="string" default="ORMService.defaultCache" tooltip="The name of the secondary cache region" />
		</dialog>
	</ide>
</response>  
</cfoutput>

 