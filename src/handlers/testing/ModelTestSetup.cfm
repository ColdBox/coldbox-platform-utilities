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

<cfheader name="Content-Type" value="text/xml">
<cfoutput>
<response status="success" type="default">
	<ide handlerfile="testing/ModelTestGenerator.cfm">
		<dialog width="600" height="400" title="ColdBox Model Test Wizard" image="includes/images/ColdBox_Icon.png">

			<input name="modelPath" label="Instantiation Path" required="true"  type="string" default=""
				   tooltip="Enter the full instantiation path of the model object to test."
				   helpmessage="Enter the full instantiation path of the model object to test." />

			<input name="style" label="Test Style" type="list" default="BDD" tooltip="The testing style to generate">
				<option value="BDD" />
				<option value="xUnit" />
			</input>

			<input name="Script" label="Script Based CFC" type="boolean" checked="true"
				   tooltip="Choose whether to create the cfc in pure script or not."
				   helpmessage="Choose whether to create the cfc in pure script or not." />

		</dialog>
	</ide>
</response>
</cfoutput>

