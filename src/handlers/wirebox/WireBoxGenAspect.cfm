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
	<ide handlerfile="wirebox/WireBoxGenAspectGenerator.cfm"> 
		<dialog width="500" height="450" title="New WireBox AOP Aspect Wizard" image="includes/images/ColdBox_Icon.png">  
			
			<input name="Name" required="true" label="Aspect Name"  type="string" default="" 
				   tooltip="Enter aspect cfc name without .cfc"
				   helpmessage="Enter aspect cfc name without .cfc" />
				   
			<input name="Description" label="Description"  type="string" default="" 
				   tooltip="Enter object description"
				   helpmessage="Enter object description for hints" />
			
			<input name="Script" label="Script Based CFC" type="boolean" checked="false" tooltip="Choose whether to create the cfc in pure script or not." />
			
			<input name="ClassMatcher" label="Class Matcher (Optional)"  type="string" default="" 
				   tooltip="Enter a class matcher if this aspect is a self binding aspect"
				   helpmessage="Enter a class matcher if this aspect is a self binding aspect" />
			
			<input name="MethodMatcher" label="Method Matcher (Optional)"  type="string" default="" 
				   tooltip="Enter a method matcher if this aspect is a self binding aspect"
				   helpmessage="Enter a method matcher if this aspect is a self binding aspect" />
			
		</dialog>
	</ide>
</response>  
</cfoutput>

 