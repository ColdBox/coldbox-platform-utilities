<!-----------------------------------------------------------------------
********************************************************************************
Copyright Since 2005 ColdBox Framework by Luis Majano and Ortus Solutions, Corp
www.coldboxframework.com | www.luismajano.com | www.ortussolutions.com
********************************************************************************
Author      :	 Sana Ullah & Luis Majano
----------------------------------------------------------------------->
<cfscript>
mappings = {
	flash = "coldbox.system.web.flash.AbstractFlashScope",
	event = "coldbox.system.web.context.RequestContext",
	controller = "coldbox.system.web.Controller",
	wireBox = "coldbox.system.ioc.Injector",
	logBox = "coldbox.system.logging.LogBox",
	log = "coldbox.system.logging.log",
	cacheBox = "coldbox.system.cache.CacheFactory"
};


// Destinations
projectLocation = data.event.ide.projectview.XMLAttributes.projectLocation & "/";
settingsLocation = projectLocation & "settings.xml";

// Add variable mappings to XML
settingsXML = xmlParse(settingsLocation);

for(key in mappings){
	// Create Var Name
	newVar = xmlElemNew(settingsXML,"VariableName");
	newVar.XMLText = lcase(key);
	// Append Variable Mapping
	arrayAppend(settingsXML.ResourceDetails.VariableMappings.xmlChildren,newVar);
	// Create Mapping
	newMapping = xmlElemNew(settingsXML,"MappedTo");
	newMapping.XMLText = mappings[key];
	// Append Variable Mapping
	arrayAppend(settingsXML.ResourceDetails.VariableMappings.xmlChildren,newMapping);
}

// Write it out
fileWrite(settingsLocation, controller.getUtility().prettifyXML(settingsXML));

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
	<dialog width="650" height="450" title="ColdBox Variable Mappings" image="includes/images/ColdBox_Icon.png"/>  
	<body><![CDATA[
	<html>
		<head>
			<base href="#controller.getBaseURL()#" />
			<link href="includes/css/styles.css" type="text/css" rel="stylesheet">
			<script type="text/javascript" src="includes/js/jquery.latest.min.js"></script>
		</head>
		<body>
			<div class="messagebox-green">CFBuilder settings.xml Modified!</div>
			
			<h2>ColdBox Project Variable Mappings</h2>
			<div class="consoleLog">
				<p>
				We have succesffully added several ColdBox variable mappings
				to your project. You should now be able to get introspection on
				the following variables:
				<ul>
					<li>event</li>
					<li>controller</li>
					<li>flash</li>
					<li>logBox</li>
					<li>log</li>
					<li>cacheBox</li>
					<li>wireBox</li>
				</ul>
				</p>
			</div>
		</body>
	</html>	
	
	]]></body>
</ide>
</cfoutput>
</response>

