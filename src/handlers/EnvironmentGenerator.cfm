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
destinationLocation = data.event.ide.projectview.resource.xmlAttributes.path & "/";
configLocation = destinationLocation & "coldbox.xml.cfm";
projectLocation = data.event.ide.projectview.XMLAttributes.projectLocation & "/";
templatesLocation = expandPath('../templates/environments') & "/";

// Create environments xml
envXML = fileRead(templatesLocation & "environments.xml.cfm");
envXML = replacenocase(envXML,"|name|",inputStruct.envName);
envXML = replacenocase(envXML,"|urls|",inputStruct.envURLs);
fileWrite(destinationLocation & "environments.xml.cfm", envXML);

// Add interceptor to XML
configXML = xmlParse(configLocation);
// Create interceptor element
interceptor = xmlElemNew(configXML,"Interceptor");
interceptor.XMLAttributes["class"] = "coldbox.system.interceptors.EnvironmentControl";
// Config File
interceptor.XMLChildren[1] = xmlElemNew(configXML,"Property");
interceptor.XMLChildren[1].XMLAttributes["name"] = "configFile";
interceptor.XMLChildren[1].xmlText = "config/environments.xml.cfm";
// Add to interceptors Array
arrayAppend(configXML.config.interceptors.xmlChildren,interceptor);
// Write it out
fileWrite(configLocation, controller.getUtility().prettifyXML(configXML));
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
			    <param key="filename" value="#destinationLocation#environments.xml.cfm" />
			</params>
		</command>
	</commands>
	<dialog width="550" height="450" title="ColdBox Environment Control Configurator" image="includes/images/ColdBox_Icon.png"/>  
	<body><![CDATA[
	<html>
		<head>
			<base href="#controller.getBaseURL()#" />
			<link href="includes/css/styles.css" type="text/css" rel="stylesheet">
			<script type="text/javascript" src="includes/js/jquery.latest.min.js"></script>
		</head>
		<body>
			<div class="messagebox-green">
				Environment Interceptor Configured!
			</div>
			
			<h2>Install Log</h2>
			<div class="consoleLog">
				Environment control file created at : <strong>config/environments.xml.cfm</strong>
			</div>
		</body>
	</html>	
	]]></body>
</ide>
</response>
</cfoutput>

