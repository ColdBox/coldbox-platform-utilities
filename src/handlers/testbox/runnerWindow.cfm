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
	// cleanup the wwwroot from the resource targeted
	bundlePath = replacenocase( data.event.ide.projectview.resource.XMLAttributes.path,
								data.event.ide.projectview.server.XMLAttributes.wwwroot,
								'' );
	testRunner = urlPath & bundlePath
	& "?reporter=#inputStruct.reporter#&labels=#inputStruct.labels#&bundles=#arguments.bundles#&directory=#arguments.directory#&recurse=#arguments.directory#";
	testRunner = xmlFormat( testRunner );
</cfscript>
<cfheader name="Content-Type" value="text/xml">
<cfoutput>
<response showresponse="true">
<cfif inputStruct.createWindow>
	<ide url="#testRunner#">
		<view id="testbox_runner" title="TestBox CPU Runner" icon="includes/images/TestBoxIcon.png">
		</view>
	</ide>
<cfelse>
	<ide url="#testRunner#">
		<dialog width="1024" height="800" title="TestBox CPU Runner" image="includes/images/TestBoxLogoSolo.png"/>
	</ide>
</cfif>
</response>
</cfoutput>