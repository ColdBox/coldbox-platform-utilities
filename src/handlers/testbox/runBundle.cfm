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
	if( !fileExists( target ) OR listLast( target, ".") neq "cfc" ){
		writedump( "You must choose a valid Test Bundle CFC!" );abort;
	}
	// create host + port URL path if server exists, else leave blank for user to add
	if( structKeyExists( data.event.ide.projectview, "server" ) ){
		// create host + port URL path
		urlPath = "http://" & data.event.ide.projectview.server.xmlAttributes.hostname & ":" & data.event.ide.projectview.server.xmlAttributes.port;
		// cleanup the wwwroot from the resource targeted
		bundlePath = replacenocase( target,
									data.event.ide.projectview.server.XMLAttributes.wwwroot,
									'' );
		testRunner = urlPath & bundlePath;
	} else {
		testRunner = "http://#getFileFromPath( target )#";
	}
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
				   default="#testRunner#" />

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

