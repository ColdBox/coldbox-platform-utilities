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
	testRunner = inputStruct.directoryRunner & "?method=runRemote&reporter=#inputStruct.reporter#&labels=#inputStruct.labels#&directory=#inputStruct.directory#&recurse=#inputStruct.recurse#";
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