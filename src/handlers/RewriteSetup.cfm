<!-----------------------------------------------------------------------
Author 	 :	Sana Ullah
Date     :	August 1, 2009
Description :
---------------------------------------------------------------------->
<cfheader name="Content-Type" value="text/xml">  
<cfoutput>  
<response status="success" type="default">  
	<ide handlerfile="RewriteGenerator.cfm"> 
		<dialog width="650" height="450" title="ColdBox URL Rewrite Configuration" image="includes/images/ColdBox_Icon.png">  
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


 