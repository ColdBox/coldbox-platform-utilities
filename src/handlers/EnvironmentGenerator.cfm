<!-----------------------------------------------------------------------
********************************************************************************
Copyright Since 2005 ColdBox Framework by Luis Majano and Ortus Solutions, Corp
www.coldboxframework.com | www.luismajano.com | www.ortussolutions.com
********************************************************************************

Author      :	 Sana Ullah & Luis Majano
Date        :	08/01/2009
----------------------------------------------------------------------->
<cfscript>
// Parse incoming event
data = xmlParse(ideeventinfo);
		
// Parse Input
extXMLInput = xmlSearch(data, "/event/user/input");
inputStruct = StructNew();
for(i=1; i lte arrayLen(extXMLInput); i++){
	StructInsert(inputStruct,"#extXMLInput[i].xmlAttributes.name#","#extXMLInput[i].xmlAttributes.value#");	
}

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
fileWrite(configLocation, request.utility.prettifyXML(configXML));
</cfscript>

<cfheader name="Content-Type" value="text/xml">  
<response status="success" showresponse="true">  
<ide>  
	<dialog width="550" height="450" title="ColdBox Environment Control Configurator" image="images/ColdBox_Icon.png"/>  
	<body><![CDATA[
	<h2>Environment Control Configured!</h2>
	<p>
		Environment control file created at : config/environments.xml.cfm
	</p>
	]]></body>
</ide>
</response>

