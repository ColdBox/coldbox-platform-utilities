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
templatesLocation = expandPath('../templates/deploy') & "/";

// Move deploy tag and ANT script
fileCopy(templatesLocation & "_deploy.tag", destinationLocation);
fileCopy(templatesLocation & "deploy.xml", destinationLocation);

// Generate Command Object?
if( inputStruct.GenerateCommandObject ){
	scriptPrefix = "";
	// Full script CFC?
	if( inputStruct.Script ){ scriptPrefix = "Script"; }
	// Copy template to model folder
	fileCopy(templatesLocation & "CommandObjectContent#scriptPrefix#.txt", projectLocation & "model\DeployCommand.cfc");
}

// Add interceptor to XML
configXML = xmlParse(configLocation);
// Create interceptor element
interceptor = xmlElemNew(configXML,"Interceptor");
interceptor.XMLAttributes["class"] = "coldbox.system.interceptors.Deploy";
// Config File
interceptor.XMLChildren[1] = xmlElemNew(configXML,"Property");
interceptor.XMLChildren[1].XMLAttributes["name"] = "tagFile";
interceptor.XMLChildren[1].xmlText = "config/_deploy.tag";
if( inputStruct.GenerateCommandObject ){
	// Deploy Command Object
	interceptor.XMLChildren[2] = xmlElemNew(configXML,"Property");
	interceptor.XMLChildren[2].XMLAttributes["name"] = "deployCommandObject";
	interceptor.XMLChildren[2].xmlText = "model.DeployCommand";
}
// Add to interceptors Array
arrayAppend(configXML.config.interceptors.xmlChildren,interceptor);
// Write it out
fileWrite(configLocation, request.utility.prettifyXML(configXML));
</cfscript>

<cfheader name="Content-Type" value="text/xml">  
<response status="success" showresponse="true">  
<ide>  
	<dialog width="550" height="450" title="ColdBox Deploy Tag Configurator" image="images/ColdBox_Icon.png"/>  
	<body><![CDATA[
	<h2>Deploy Interceptor Configured!</h2>
	<p>
		Deploy tag created: config/_deploy.tag<br/>
		ANT Task created: config/deploy.xml		
		<cfif inputStruct.GenerateCommandObject>
		<br/>
		Deploy Command Object created in your model folder as <strong>DeployCommand.cfc</strong>
		</cfif>
	</p>
	]]></body>
</ide>
</response>

