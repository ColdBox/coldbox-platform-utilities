<!-----------------------------------------------------------------------
********************************************************************************
Copyright Since 2005 ColdBox Framework by Luis Majano and Ortus Solutions, Corp
www.coldboxframework.com | www.luismajano.com | www.ortussolutions.com
********************************************************************************
----------------------------------------------------------------------->
<cfscript>
	// Get the runner URL to use
	browserURL = controller.getTestBoxBrowserURL();
</cfscript>
<!--- Output --->
<cfheader name="Content-Type" value="text/xml">
<cfoutput>
<response status="success" type="default">
	<ide handlerfile="testbox/openBrowserWindow.cfm">
		<dialog width="700" height="300" title="TestBox Browser Window" image="includes/images/TestBoxLogoSolo.png">

			<input name="browserURL" label="Browser URL"
				   tooltip="The browser URL to create a window for"
				   type="projectfile"
				   required="true"
				   default="#browserURL#" />

		</dialog>
	</ide>
</response>
</cfoutput>

