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
templatesLocation = expandPath('../templates/reactor') & "/";

// Move reactor.xml
fileCopy(templatesLocation & "reactor.xml.cfm", destinationLocation);

// Create reactor model folder
if( NOT directoryExists(projectLocation & "model/reactor") ){
	request.utility.createDirectory(projectLocation & "model/reactor");
}

// Add interceptor to XML
configXML = xmlParse(configLocation);
// Create interceptor element
interceptor = xmlElemNew(configXML,"Interceptor");
interceptor.XMLAttributes["class"] = "coldbox.system.orm.reactor.ReactorLoader";
// Dsn Alias
interceptor.XMLChildren[1] = xmlElemNew(configXML,"Property");
interceptor.XMLChildren[1].XMLAttributes["name"] = "dsnAlias";
interceptor.XMLChildren[1].xmlText = inputStruct.dsnAlias;
// Config File
interceptor.XMLChildren[2] = xmlElemNew(configXML,"Property");
interceptor.XMLChildren[2].XMLAttributes["name"] = "pathToConfigXML";
interceptor.XMLChildren[2].xmlText = "${AppMapping}/config/reactor.xml.cfm";
//Project
interceptor.XMLChildren[3] = xmlElemNew(configXML,"Property");
interceptor.XMLChildren[3].XMLAttributes["name"] = "project";
interceptor.XMLChildren[3].xmlText = inputStruct.projectName;
//Mapping
interceptor.XMLChildren[4] = xmlElemNew(configXML,"Property");
interceptor.XMLChildren[4].XMLAttributes["name"] = "mapping";
interceptor.XMLChildren[4].xmlText = "${AppMapping}/model/reactor";
// Mode
interceptor.XMLChildren[5] = xmlElemNew(configXML,"Property");
interceptor.XMLChildren[5].XMLAttributes["name"] = "mode";
interceptor.XMLChildren[5].xmlText = "development";

// Check if there are any datasources:
if( NOT structKeyExists(configXML.config,"Datasources") ){
	datasources = xmlElemNew(configXML,"Datasources");
	configXML.config.datasources = datasources;
}
// Create Datasource
if( NOT arrayLen(xmlSearch(configXML,"//Datasource[@name='#inputStruct.dsnName#']")) ){
	dsn = xmlElemNew(configXML, "Datasource");
	dsn.XMLAttributes["name"] = inputStruct.dsnName;
	dsn.XMLAttributes["alias"] = inputStruct.dsnAlias;
	if( structKeyExists(inputStruct,"dsnType") ){
		dsn.XMLAttributes["dbtype"] = inputStruct.dsnType;
	}
	arrayAppend(configXML.config.datasources.xmlChildren,dsn);
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
	<h2>Reactor ORM Configured!</h2>
	<p>
	Reactor XML file created at : <em>config/reactor.xml.cfm</em> <br/>
	Reactor model folder created at : <em>model/reactor</em> <br/>
	Datasource added to config and interceptor configured. <br/>
	</p>
	<p><strong>Please make sure your datasource is created in the CF server</strong></p>
	]]></body>
</ide>
</response>

