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
	<ide handlerfile="DeployGenerator.cfm"> 
		<dialog width="400" height="250" title="ColdBox Deploy Interceptor Configurator" image="includes/images/ColdBox_Icon.png">  
			<input name="GenerateCommandObject" label="Generate a deploy command model object (model folder)" type="boolean" 
				   tooltip="Generate a deploy command model object in the default model folder" />
			<input name="Script" label="Script Based CFC" type="boolean" checked="false" 
				   tooltip="Choose whether to create the cfc in pure script or not." />
		</dialog>
	</ide>
</response>  
</cfoutput>