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
<ide handlerfile="wirebox/WireBoxProviderMethodGenerator.cfm"> 
	<dialog width="500" height="400" title="WireBox Provider Method Generation" image="includes/images/ColdBox_Icon.png">  
		<input name="providerName" label="Provider Name" type="string" required="true" 
			   tooltip="The name of the provider to use for the generated method."/>
		
		<input name="methodName" label="Method Name" type="string" required="true" 
			   tooltip="The name of the method to create" />
		
		<input name="Script" label="Script Based Function" type="boolean" checked="true" 
			   tooltip="Choose whether to create the function in pure script or tag." />
		
		<input name="returnType" label="Return Type" type="string" required="true" default="any"
			   tooltip="The return type of the function" />
		
	</dialog>
</ide>
</response>  
</cfoutput>