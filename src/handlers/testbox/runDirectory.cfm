<!-----------------------------------------------------------------------
********************************************************************************
Copyright Since 2005 ColdBox Framework by Luis Majano and Ortus Solutions, Corp
www.coldboxframework.com | www.luismajano.com | www.ortussolutions.com
********************************************************************************
----------------------------------------------------------------------->
<cfscript>

	// target path
	target = controller.getProjectResource().path;
	// Verify Directory Exists
	if( !directoryExists( target ) ){
		writedump( "You must choose a valid directory to tests. The directory '#target#' does not exist or is not a directory" );abort;
	}
	// Get directory runner.
	runnerURL = controller.getTestBoxRunner();
	// Discover directory instanation path
	if( structKeyExists( data.event.ide.projectview, "server" ) ){
		// cleanup the wwwroot from the resource targeted
		dirPath = replacenocase( target,
							 	 data.event.ide.projectview.server.XMLAttributes.wwwroot,
							 	 '' );
		dirPath = rereplace( reReplace( dirPath, "(\/|\\)", ".", "all" ), "^.", "" );
	} else {
		dirPath = replacenocase( target,
							 	 data.event.ide.projectview.XMLAttributes.projectLocation,
							 	 '' );
		dirPath = rereplace( reReplace( target, "(\/|\\)", ".", "all" ), "^.", "" );
	}
</cfscript>
<!--- Output --->
<cfheader name="Content-Type" value="text/xml">
<cfoutput>
<response status="success" type="default">
	<ide handlerfile="testbox/runDirectoryWindow.cfm">
		<dialog width="800" height="400" title="TestBox Bundle Runner" image="includes/images/TestBoxLogoSolo.png">

			<input name="directory" label="Directory"
				   tooltip="The Directory instantation path to execute"
				   type="string"
				   required="true"
				   default="#dirPath#" />

			<input name="recurse" label="Recurse"
				   tooltip="Recurse execution or not"
				   type="Boolean"
				   checked="true" />

			<input name="directoryRunner" label="Runner URL"
				   tooltip="The URL of the runner to use"
				   type="string"
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

