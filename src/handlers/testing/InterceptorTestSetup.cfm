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
	<ide handlerfile="testing/InterceptorTestGenerator.cfm"> 
		<dialog width="600" height="400" title="ColdBox Interceptor Test Wizard" image="includes/images/ColdBox_Icon.png">  
			
			<input name="interceptorPath" label="Instantiation Path" required="true"  type="string" default="" 
				   tooltip="Enter the full instantiation path of the interceptor object to test."
				   helpmessage="Enter the full instantiation path of the interceptor object to test." />
			
			<input name="Script" label="Script Based CFC" type="boolean" checked="false" 
				   tooltip="Choose whether to create the cfc in pure script or not."
				   helpmessage="Choose whether to create the cfc in pure script or not." />
			
			<input name="InterceptionPoints" label="Points to test" type="string" default="" /> 
				   
		</dialog>
	</ide>
</response>  
</cfoutput>

 