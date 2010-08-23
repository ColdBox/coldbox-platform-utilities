<!-----------------------------------------------------------------------
********************************************************************************
Copyright Since 2005 ColdBox Framework by Luis Majano and Ortus Solutions, Corp
www.coldboxframework.com | www.luismajano.com | www.ortussolutions.com
********************************************************************************

Author      :	 Sana Ullah & Luis Majano
Date        :	08/01/2009
----------------------------------------------------------------------->
<cfheader name="Content-Type" value="text/xml">  
<cfoutput>  
<response status="success" type="default">  
	<ide handlerfile="SecurityGenerator.cfm"> 
		<dialog width="450" height="350" title="ColdBox Security Interceptor Configurator" image="includes/images/ColdBox_Icon.png">  
			<input name="rulesSource" label="Rules Source" type="list" 
				   default="xml" helpmessage="There are more rule sources but this generator defaults to xml file.">
				<option value="xml" />
			</input>	
			<input name="useRegex" label="Use regex matching" checked="true" type="Boolean" 
			       helpmessage="Use regex matching on event patterns" />
			<input name="generateValidator" label="Generate Custom User Validator" checked="true" type="Boolean"
				   helpmessage="Generates a user validator object in your model folder" />
			<input name="Script" label="Script Based CFC" type="boolean" checked="false" 
				   tooltip="Choose whether to create the cfc in pure script or not." />
			
		</dialog>
	</ide>
</response>  
</cfoutput>