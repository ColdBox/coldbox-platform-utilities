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
* Provider method for #inputStruct.providerName#
*/
#inputStruct.returnType# function #inputStruct.methodName#() provider="#inputStruct.providerName#"{}
<cfelse>
#sTag#function name="#inputStruct.methodName#" output="false" access="public" returnType="#inputStruct.returnType#" hint="Provider Method for: #inputStruct.providerName#" provider="#inputStruct.providerName#">	
#eTag#function>
</cfif>
				 ]]> 
				</param> 
			</params> 
		</command> 
	</commands> 
</ide>
</response>
</cfoutput>
