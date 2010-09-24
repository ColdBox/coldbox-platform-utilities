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
	<ide handlerfile="orm/ORMEventHandlerGenerator.cfm"> 
		<dialog width="600" height="550" title="ColdBox ORM Event Handler Wizard" image="includes/images/ColdBox_Icon.png">  
		
			<input name="Name" label="Event Handler File Name" required="true"  type="string" default="EventHandler" 
					tooltip="The name of your ORM Event Handler Object (no .cfc)" />
		</dialog>
	</ide>
</response>  
</cfoutput>

 