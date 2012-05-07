<!-----------------------------------------------------------------------
********************************************************************************
Copyright Since 2005 ColdBox Framework by Luis Majano and Ortus Solutions, Corp
www.coldboxframework.com | www.luismajano.com | www.ortussolutions.com
********************************************************************************

Author      :	 Sana Ullah & Luis Majano
Date        :	08/01/2009
----------------------------------------------------------------------->
<cfscript>
// Destinations
projectLocation 	= data.event.ide.projectview.XMLAttributes.projectLocation & "/";
routesLocation 		= projectLocation & "config/Routes.cfm";
templatesLocation 	= expandPath('/coldboxExtension/templates/ses') & "/";

// Move rewrite engine
switch(inputStruct.rewriteEngine){
	case "mod_rewrite" : {
		copiedFile = ".htaccess";
		fileCopy(templatesLocation & ".htaccess", projectLocation  & ".htaccess");
		break;
	}
	case "IIS 7 Rewrite Module" :{
		copiedFile = "web.config";
		fileCopy(templatesLocation & "web.config", projectLocation  & "web.config");
		break;
	}
	case "ISAPI" : {
		copiedFile = "IsapiRewrite4.ini";
		fileCopy(templatesLocation & "IsapiRewrite4.ini", projectLocation & "IsapiRewrite4.ini");
		break;
	}
}
// Remove index.cfm from routes.cfm
routes = fileRead(routesLocation);
routes = replacenocase(routes,"index.cfm","","all");
fileWrite(routesLocation,routes);

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
			    <param key="filename" value="#routesLocation#" />
			</params>
		</command>
		<command type="openfile">
			<params>
			    <param key="filename" value="#projectLocation & copiedFile#" />
			</params>
		</command>
	</commands>
	<dialog width="650" height="450" title="ColdBox URL Rewrite Rules Created" image="includes/images/ColdBox_Icon.png"/>
	<body><![CDATA[
	<html>
		<head>
			<base href="#controller.getBaseURL()#" />
			<link href="includes/css/styles.css" type="text/css" rel="stylesheet">
			<script type="text/javascript" src="includes/js/jquery.latest.min.js"></script>
		</head>
		<body>
			<div class="messagebox-green">Rewrite Rules File Created!</div>

			<h2>Install Log</h2>
			<div class="consoleLog">
				<p>
				The <em>#inputStruct.rewriteEngine#</em> URL rewrite rules have been created in your root folder as
				<strong>#copiedFile#</strong>. <br/>
				Your <em>Routes.cfm</em> file has been modified to remove any <em>index.cfm</em> references.
				</p>
			</div>
		</body>
	</html>

	]]></body>
</ide>
</cfoutput>
</response>

