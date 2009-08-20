<!-----------------------------------------------------------------------
Author 	 :	Sana Ullah
Date     :	August 1, 2009
Description :
---------------------------------------------------------------------->
<cflog file="ColdBoxCFBuilder" text="Executing HandlerSetup.cfm #timeFormat(now())#">
<cftry>

<cfparam name="ideeventinfo"> 
<cfset data = xmlParse(ideeventinfo)>

<cfheader name="Content-Type" value="text/xml">  
<cfoutput>  
<response status="success" type="default">  
	<ide handlerfile="HandlerGenerator.cfm"> 
		<dialog width="450" height="450">  
			<input name="HandlerName" Lable="Enter handler name"  type="string" default="" tooltip="Enter handler cfc name without .cfc" />					
		</dialog>
	</ide>
</response>  
</cfoutput>

<cfcatch type="any">
	<cflog file="ColdBoxCFBuilder" text="#cfcatch.message#">
</cfcatch>
</cftry>


 