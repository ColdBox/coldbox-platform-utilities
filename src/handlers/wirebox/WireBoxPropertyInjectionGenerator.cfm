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
<cfscript>
// Check scope
scope = "";
if( len(inputStruct.scope) and inputStruct.scope neq "variables" ){
	scope = ' scope="#inputStruct.scope#"';
}
// injectionDSL
injectionDSL = inputStruct.DSLNamespace;
// check custom
if( len(inputStruct.customDSLNamespace) ){ injectionDSL = inputStruct.customDSLNamespace; }
// DSL context
if( len(inputStruct.DSLContext) ){
	injectionDSL &= ":" & inputStruct.DSLContext;
}

// CFproperty Tag
propertyTag = "<cfproperty";

</cfscript>


<!--- Display --->
<cfheader name="Content-Type" value="text/xml">  
<cfoutput>
<response status="success" showresponse="true">  
<ide>  
	<commands> 
		<command type="inserttext"> 
			<params> 
				<param key="text" > 
				<![CDATA[ 
				<cfif inputStruct.Script>
					property name="#inputStruct.name#" inject="#injectionDSL#"#scope#;
				<cfelse>
					#propertyTag# name="#inputStruct.name#" inject="#injectionDSL#"#scope#>
				</cfif>
				 ]]> 
				</param> 
			</params> 
		</command> 
	</commands> 
</ide>
</response>
</cfoutput>
