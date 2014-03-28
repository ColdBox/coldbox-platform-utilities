<!-----------------------------------------------------------------------
********************************************************************************
Copyright Since 2005 ColdBox Framework by Luis Majano and Ortus Solutions, Corp
www.coldboxframework.com | www.luismajano.com | www.ortussolutions.com
********************************************************************************
Author      :	 Sana Ullah & Luis Majano
----------------------------------------------------------------------->
<cfscript>
// target + harness location
target = data.event.ide.projectview.resource.XMLAttributes.path & "/test-harness";
harnessLocation = expandPath( "/cpu/templates/testbox/test-harness");
// generate it
controller.getUtility()
	.directoryCopy( harnessLocation, target );
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
	<dialog width="650" height="450" title="TestBox Harness Created" image="includes/images/ColdBox_Icon.png"/>
	<body><![CDATA[
	<html>
		<head>
			<base href="#controller.getBaseURL()#" />
			<link href="includes/css/styles.css" type="text/css" rel="stylesheet">
			<script type="text/javascript" src="includes/js/jquery.latest.min.js"></script>
		</head>
		<body>
			<h2>TestBox Harness Created</h2>
			<p>A brand new TestBox Harness has been generated for you at <strong>#target#</strong> with the following files:</p>
<div class="consoleLog">
<ul>
	<li>Application.cfc - A harness bootstrap</li>
	<li>runner.cfm - An HTML runner</li>
	<li>test.xml - An ANT runner</li>
	<li>results - Where automated results go</li>
	<li>specs - Where your test specs go</li>
</ul>
</div>
		</body>
	</html>

	]]></body>
</ide>
</cfoutput>
</response>

