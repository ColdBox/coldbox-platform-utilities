<!-----------------------------------------------------------------------
********************************************************************************
Copyright Since 2005 ColdBox Framework by Luis Majano and Ortus Solutions, Corp
www.coldboxframework.com | www.luismajano.com | www.ortussolutions.com
********************************************************************************

Author      :	 Sana Ullah & Luis Majano
Date        :	08/01/2009
----------------------------------------------------------------------->
<cfheader name="Content-Type" value="text/xml">
<cfoutput>
<response status="success" type="default">
	<ide handlerfile="project/RewriteGenerator.cfm">
		<dialog width="650" height="450" title="ColdBox URL Rewrite Configuration" image="includes/images/ColdBox_Icon.png">
			<input name="rewriteEngine" label="Choose Rewrite Engine Rules" type="list" default="mod_rewrite"
				   tooltip="Choose the rewrite engine to create rules for"
				   helpmessage="Choose the rewrite engine to create rules for">
				<option value="mod_rewrite" />
				<option value="IIS 7 Rewrite Module" />
				<option value="ISAPI" />
			</input>
		</dialog>
	</ide>
</response>
</cfoutput>


