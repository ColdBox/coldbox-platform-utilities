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
// injectionDSL
injectionDSL = inputStruct.DSLNamespace;
// check custom
if( len(inputStruct.customDSLNamespace) ){ injectionDSL = inputStruct.customDSLNamespace; }
// DSL Context
if( len(inputStruct.DSLContext) ){
	injectionDSL &= inputStruct.DSLContext;
}
beanName = lcase(left(inputStruct.beanName,1)) & right(inputStruct.beanName, len(inputStruct.beanName) -1 );

// CFFunction Tag
sTag = "<cf";
eTag = "</cf";

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
/**
* Set the #inputStruct.beanName# (DI)<cfif inputStruct.annotationType eq "comment">
* @inject #injectionDSL#</cfif>
*/
void function set#inputStruct.beanName#(#beanName#) <cfif inputStruct.annotationType eq "inline">inject="#injectionDSL#"</cfif>{
	variables.#beanName# = arguments.#beanName#;
}
<cfif inputStruct.getter>
/**
* Getter for #inputStruct.beanName#
*/
any function get#inputStruct.beanName#(){
	return variables.#beanName#;
}
</cfif>
<cfelse>
#sTag#function name="set#inputStruct.beanName#" inject="#injectionDSL#" output="false" access="public" returnType="void" hint="Set the #inputStruct.beanName# (DI)">
	#sTag#argument name="#beanName#" required="true" type="any">
	#sTag#set variables.#beanName# = arguments.#beanName#>					
#eTag#function>
<cfif inputStruct.getter>
#sTag#function name="get#inputStruct.beanName#" output="false" access="public" returnType="any" hint="Get the #inputStruct.beanName#">
	#sTag#return variables.#beanName#>					
#eTag#function>
</cfif>
</cfif>

				 ]]> 
				</param> 
			</params> 
		</command> 
	</commands> 
</ide>
</response>
</cfoutput>
