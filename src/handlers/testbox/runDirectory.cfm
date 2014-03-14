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
	// target path
	target = data.event.ide.projectview.resource.XMLAttributes.path;
	// Verify Bundle
	if( !directoryExists( target ) ){
		writedump( "You must choose a valid directory to test! #target# is not a directory" );abort;
	}
</cfscript>
<!--- Output --->
<cfheader name="Content-Type" value="text/xml">
<cfoutput>
<response status="success" type="default">
	<ide handlerfile="testbox/runDirectoryWindow.cfm">
		<dialog width="550" height="300" title="TestBox Directory Runner" image="includes/images/TestBoxLogoSolo.png">

			<input name="directory" label="Directory"
				   tooltip="The directory to test"
				   type="dir"
				   default="#target#" />

			<input name="recurse" label="Recurse"
				   tooltip="Recursive test execution"
				   type="Boolean"
				   checked="true" />

			<input name="reporter" label="Reporter" type="list" default="simple">
			<cfloop array="#controller.getUtility().getTestBoxReporters()#" index="i">
				<option value="#i#" />
			</cfloop>
			</input>

			<input name="createWindow" label="Create Window"
				   tooltip="Whether it just runs and presents results or we create a window in the IDE"
				   type="Boolean"
				   checked="false" />

			<input name="labels" label="Labels"
				   tooltip="Labels to apply for this execution"
				   type="string"
				   checked="false" />
		</dialog>
	</ide>
</response>
</cfoutput>

