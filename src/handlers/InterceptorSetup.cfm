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
<response>  
	<ide handlerfile="InterceptorGenerator.cfm"> 
		<dialog width="700" height="450" title="ColdBox Interceptor Wizard" image="includes/images/ColdBox_Icon.png">  
			<input name="Name" label="Enter interceptor name" required="true"  type="string" default="" tooltip="Enter interceptor cfc name without .cfc" />
			<input name="Description" label="Enter interceptor description"  type="string" default="" tooltip="Enter interceptor description" />					
			<input name="Script" label="Script Based CFC" type="boolean" checked="false" tooltip="Choose whether to create the cfc in pure script or not." />
			<input name="InterceptionPoints" label="Create the following interception points" type="string" default="" /> 
			
			<input name="GenerateTest" label="Generate Unit Test" type="boolean" 
				   tooltip="Generate the unit test component"
				   helpmessage="Generate the unit test component" />
			
			<input name="TestsDirectory" label="Unit Tests Directory" type="projectdir" 
				   default="#data.event.ide.projectview.xmlattributes.projectlocation#/test/unit" 
				   tooltip="Your unit tests directory"
				   helpmessage="Your unit tests directory" />
		</dialog>
	</ide>
</response>  
</cfoutput>

 