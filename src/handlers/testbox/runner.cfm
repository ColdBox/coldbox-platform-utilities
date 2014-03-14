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
	if( !fileExists( target ) OR listLast( target, ".") neq "cfm" ){
		writedump( "You must choose a valid TestBox Runner cfm template!" );abort;
	}
</cfscript>
<!--- Output --->
<cfheader name="Content-Type" value="text/xml">
<cfoutput>
<response status="success" type="default">
	<ide handlerfile="testbox/runBundleWindow.cfm">
		<dialog width="550" height="400" title="TestBox Bundle Runner" image="includes/images/TestBoxLogoSolo.png">

			<input name="bundles" label="Bundles"
				   tooltip="The bundle(s) paths to test, leave blank for runner to use defaults"
				   type="string"
				   checked="false" />

			<input name="directory" label="Directory"
				   tooltip="The directory instantiation path"
				   type="string"
				   checked="false" />

			<input name="recurse" label="Recurse"
				   tooltip="Directory recursion"
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

