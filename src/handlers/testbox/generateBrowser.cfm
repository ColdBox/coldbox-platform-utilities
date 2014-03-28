<!-----------------------------------------------------------------------
********************************************************************************
Copyright Since 2005 ColdBox Framework by Luis Majano and Ortus Solutions, Corp
www.coldboxframework.com | www.luismajano.com | www.ortussolutions.com
********************************************************************************
----------------------------------------------------------------------->
<!--- Output --->
<cfheader name="Content-Type" value="text/xml">
<cfoutput>
<response status="success" type="default">
	<ide handlerfile="testbox/generateBrowserNow.cfm">
		<dialog width="500" height="400" title="TestBox Browser Generator" image="includes/images/TestBoxLogoSolo.png">

			<input name="directory" label="Browser Root"
				   tooltip="The mapping of the directory to set this browser to"
				   type="dir"
				   required="true" />

		</dialog>
	</ide>
</response>
</cfoutput>