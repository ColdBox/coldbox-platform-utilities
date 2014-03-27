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
	// verify server
	if( !structKeyExists( data.event.ide.projectview, "server" ) ){
		writedump( "You must have a server defined in your project settings, define one now please.
					Right click on your project > Properties > ColdFusion Server Settings" );abort;
	}
	// create host + port URL path
	urlPath = "http://" & data.event.ide.projectview.server.xmlAttributes.hostname & ":" & data.event.ide.projectview.server.xmlAttributes.port;
	// target runner path
	target = data.event.ide.projectview.resource.XMLAttributes.path;
	// test runner URL
	testRunner = urlPath & inputStruct.runnerURL & "?method=runRemote&reporter=#inputStruct.reporter#&recurse=#inputStruct.recurse#";
	// Append things that have value
	if( len( inputStruct.labels ) ){ testRunner &= "&labels=#inputStruct.labels#"; }
	if( len( inputStruct.bundles) ){ testRunner &= "&bundles=#inputstruct.bundles#"; }
	if( len( inputStruct.directory) ){ testRunner &= "&directory=#inputstruct.directory#"; }
	if( len( inputStruct.reportpath) ){ testRunner &= "&directory=#inputstruct.reportpath#"; }
	// format it
	testRunner = xmlFormat( testRunner );
</cfscript>
<cfheader name="Content-Type" value="text/xml">
<cfoutput>
<response showresponse="true">
<cfif inputStruct.createWindow>
	<ide url="#testRunner#">
		<view id="testbox_runner" title="TestBox HTML Runner" icon="includes/images/TestBoxIcon.png">
		</view>
	</ide>
<cfelse>
	<ide url="#testRunner#">
		<dialog width="1024" height="800" title="TestBox HTML Runner" image="includes/images/TestBoxLogoSolo.png"/>
	</ide>
</cfif>
</response>
</cfoutput>