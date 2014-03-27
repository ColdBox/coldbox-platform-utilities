<!-----------------------------------------------------------------------
********************************************************************************
Copyright Since 2005 ColdBox Framework by Luis Majano and Ortus Solutions, Corp
www.coldboxframework.com | www.luismajano.com | www.ortussolutions.com
********************************************************************************
Author      :	 Sana Ullah & Luis Majano
----------------------------------------------------------------------->
<cfscript>
// Destinations
projectLocation = data.event.ide.projectview.XMLAttributes.projectLocation & "/";
settingsLocation = projectLocation & "cpu.json";
// Check if file does not exist
if( !fileExists( settingsLocation ) ){
	// create it
	fileCopy( expandPath( "/cpu/templates/cpu.json"), settingsLocation );
}
</cfscript>
<cfheader name="Content-Type" value="text/xml">
<cfoutput>
<response status="success" showresponse="true">
<ide>
	<commands>
		<command type="RefreshProject">
			<params>
			    <param key="projectname" value="#data.event.ide.projectview.xmlAttributes.projectname#" />
			</params>
		</command>
		<command type="openfile">
			<params>
				<param key="filename" value="#settingsLocation#" />
			</params>
		</command>
	</commands>
	<dialog width="650" height="450" title="CPU Config File" image="includes/images/ColdBox_Icon.png"/>
	<body><![CDATA[
	<html>
		<head>
			<base href="#controller.getBaseURL()#" />
			<link href="includes/css/styles.css" type="text/css" rel="stylesheet">
			<script type="text/javascript" src="includes/js/jquery.latest.min.js"></script>
		</head>
		<body>
			<h2>CPU Config File</h2>
			<p>You can use the ColdBox Platform Utilities config file to tell the extension where your project is in the server, 
			what TestBox Runner to use and much more configurations.  Just fill out the JSON according to our spec below.</p>
<div class="consoleLog">
<pre>
{
  "projectURL" : "http://cf10presso.jfetmac/cbTraining/",
  "testbox" : {
    "runnerURL" : "http://cf10presso.jfetmac/cbTraining/test/runner.cfm"
  }
}
</pre>
</div>
		</body>
	</html>

	]]></body>
</ide>
</cfoutput>
</response>

