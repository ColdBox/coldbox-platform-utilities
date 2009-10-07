<!-----------------------------------------------------------------------
Author 	 :	Sana Ullah
Date     :	August 1, 2009
Description :
---------------------------------------------------------------------->
<cftry>
<cfset data = xmlParse(ideeventinfo)>

<cfheader name="Content-Type" value="text/xml">  
<cfoutput>  
<response status="success" type="default">  
	<ide handlerfile="RewriteGenerator.cfm"> 
		<dialog width="450" height="200" title="ColdBox URL Rewrite Configuration" image="images/ColdBox_Icon.png">  
			<input name="rewriteEngine" label="Choose Rewrite Engine Rules" type="list" default="mod_rewrite"
				   tooltip="Choose the rewrite engine to create rules for"
				   helpmessage="Choose the rewrite engine to create rules for">
				<option value="mod_rewrite" />
				<option value="ISAPI" />
			</input>	
		</dialog>
	</ide>
</response>  
</cfoutput>

<cfcatch type="any">
	<cflog file="ColdBoxCFBuilder" text="#cfcatch.message#">
</cfcatch>
</cftry>


 