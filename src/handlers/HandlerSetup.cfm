<!-----------------------------------------------------------------------
Author 	 :	Sana Ullah
Date     :	August 1, 2009
Description :
---------------------------------------------------------------------->
<cftry>

<cfparam name="ideeventinfo"> 
<cfset data = xmlParse(ideeventinfo)>

<cfheader name="Content-Type" value="text/xml">  
<cfoutput>  
<response status="success" type="default">  
	<ide handlerfile="HandlerGenerator.cfm"> 
		<dialog width="450" height="450" title="ColdBox Event Handler Wizard" image="images/ColdBox_Icon.png">  
			<input name="Name" label="Enter handler name" required="true"  type="string" default="" tooltip="Enter handler cfc name without .cfc" />
			<input name="Description" label="Enter handler description"  type="string" default="" tooltip="Enter handler description" />					
		</dialog>
	</ide>
</response>  
</cfoutput>

<cfcatch type="any">
	<cflog file="ColdBoxCFBuilder" text="#cfcatch.message#">
</cfcatch>
</cftry>


 