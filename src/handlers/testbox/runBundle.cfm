<!-----------------------------------------------------------------------
********************************************************************************
Copyright Since 2005 ColdBox Framework by Luis Majano and Ortus Solutions, Corp
www.coldboxframework.com | www.luismajano.com | www.ortussolutions.com
********************************************************************************
----------------------------------------------------------------------->
<cfscript>
	// target CFC path
	if( structKeyExists( data.event.ide, "projectview") ){
		target = data.event.ide.projectview.resource.XMLAttributes.path;
		projectLocation = "";
	} else {
		// editor view
		target = data.event.ide.editor.file.XMLAttributes.location;
		projectLocation = data.event.ide.editor.file.XMLAttributes.projectLocation;
	}
	// Verify Bundle is a CFC
	if( !fileExists( target ) OR listLast( target, ".") neq "cfc" ){
		writedump( "You must choose a valid Test Bundle CFC!" );abort;
	}
	// Get the runner URL to use
	runnerURL = controller.getBundleURL( target, projectLocation );
</cfscript>
<!--- Output --->
<cfheader name="Content-Type" value="text/xml">
<cfoutput>
<response status="success" type="default">
	<ide handlerfile="testbox/runBundleWindow.cfm">
		<dialog width="800" height="400" title="TestBox Bundle Runner" image="includes/images/TestBoxLogoSolo.png">

			<input name="bundleURL" label="Bundle URL"
				   tooltip="The bundle URL to execute"
				   type="projectfile"
				   required="true"
				   default="#runnerURL#" />

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

