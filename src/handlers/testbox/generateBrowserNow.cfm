<!-----------------------------------------------------------------------
********************************************************************************
Copyright Since 2005 ColdBox Framework by Luis Majano and Ortus Solutions, Corp
www.coldboxframework.com | www.luismajano.com | www.ortussolutions.com
********************************************************************************
Author      :	 Sana Ullah & Luis Majano
----------------------------------------------------------------------->
<cfscript>
// target + harness location
target = data.event.ide.projectview.resource.XMLAttributes.path & "/test-browser";
harnessLocation = expandPath( "/cpu/templates/testbox/test-browser");
// generate it
controller.getUtility()
	.directoryCopy( harnessLocation, target );

// Copy over root
browserContent = fileRead( target & "/index.cfm" );
browserContent = replacenocase( browserContent, "/coldbox/testing", inputstruct.directory );
fileWrite( target & "/index.cfm", browserContent );

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
	</commands>
	<dialog width="650" height="450" title="TestBox Browser Created" image="includes/images/ColdBox_Icon.png"/>
	<body><![CDATA[
	<html>
		<head>
			<base href="#controller.getBaseURL()#" />
			<link href="includes/css/styles.css" type="text/css" rel="stylesheet">
			<script type="text/javascript" src="includes/js/jquery.latest.min.js"></script>
		</head>
		<body>
			<h2>TestBox Browser Created</h2>
			<p>A TestBox Browser has been created rooted at <strong>#target#</strong>.  You can configure your <strong>cpu.json</strong> configuration
			to point to it using the <strong>browserURL</strong> setting so you can open it via the extension as a window.</p>
<div class="consoleLog">
<pre>
{
  "projectURL" : "http://cf10presso.jfetmac/cbTraining/",
  "testbox" : {
    "runnerURL" : "http://cf10presso.jfetmac/cbTraining/tests/runner.cfm",
    "browserURL" : "http://cf10presso.jfetmac/cbTraining/test-browser/index.cfm"
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

