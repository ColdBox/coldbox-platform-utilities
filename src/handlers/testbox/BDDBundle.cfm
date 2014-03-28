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
	<ide handlerfile="testbox/BDDBundleGenerate.cfm">
		<dialog width="500" height="300	" title="TestBox BDD Creator" image="includes/images/TestBoxLogoSolo.png">

			<input name="bundleName" label="Bundle Name"
				   tooltip="The bundle name"
				   type="string"
				   required="true"/>

		</dialog>
	</ide>
</response>
</cfoutput>

