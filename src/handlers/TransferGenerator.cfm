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
templatesLocation = expandPath('../templates/transfer') & "/";

// Move new transfer.xml
fileCopy(templatesLocation & "transfer.xml.cfm", destinationLocation);

// Create definitions folder
if( NOT directoryExists(destinationLocation & "definitions") ){
	request.utility.createDirectory(destinationLocation & "definitions");
}

// Add interceptor to XML
configXML = xmlParse(configLocation);
// Create interceptor element
interceptor = xmlElemNew(configXML,"Interceptor");
interceptor.XMLAttributes["class"] = "coldbox.system.orm.transfer.TransferLoader";
// Config File
interceptor.XMLChildren[1] = xmlElemNew(configXML,"Property");
interceptor.XMLChildren[1].XMLAttributes["name"] = "configPath";
interceptor.XMLChildren[1].xmlText = "${AppMapping}/config/transfer.xml.cfm";
// Definitions Path
interceptor.XMLChildren[2] = xmlElemNew(configXML,"Property");
interceptor.XMLChildren[2].XMLAttributes["name"] = "definitionPath";
interceptor.XMLChildren[2].xmlText = "${AppMapping}/config/definitions";
//DatasourceAlias
interceptor.XMLChildren[3] = xmlElemNew(configXML,"Property");
interceptor.XMLChildren[3].XMLAttributes["name"] = "datasourceAlias";
interceptor.XMLChildren[3].xmlText = inputStruct.dsnAlias;
//BeanInjector
interceptor.XMLChildren[4] = xmlElemNew(configXML,"Property");
interceptor.XMLChildren[4].XMLAttributes["name"] = "loadBeanInjector";
interceptor.XMLChildren[4].xmlText = inputStruct.loadBeanInjector;
// BeanInjector props
if( inputStruct.loadBeanInjector ){
	interceptor.XMLChildren[5] = xmlElemNew(configXML,"Property");
	interceptor.XMLChildren[5].XMLAttributes["name"] = "BeanInjectorProperties";
	interceptor.XMLChildren[5].xmlText = "{'useSetterInjection':'#inputStruct.diSetterInjection#','stopRecursion':'#inputStruct.diStopRecursion#'}";
}

// Check if there are any datasources:
if( NOT structKeyExists(configXML.config,"Datasources") ){
	datasources = xmlElemNew(configXML,"Datasources");
	configXML.config.datasources = datasources;
}
// Create Datasource
dsn = xmlElemNew(configXML, "Datasource");
dsn.XMLAttributes["name"] = inputStruct.dsnName;
dsn.XMLAttributes["alias"] = inputStruct.dsnAlias;
if( structKeyExists(inputStruct,"dsnType") ){
	dsn.XMLAttributes["dbtype"] = inputStruct.dsnType;
}
arrayAppend(configXML.config.datasources.xmlChildren,dsn);

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
	<h2>Transfer ORM Configured!</h2>
	<p>
	Transfer XML file created at : <em>config/transfer.xml.cfm</em> <br/>
	Transfer definitioins folder created at : <em>config/definitions</em> <br/>
	Datasource added to config and interceptor configured. <br/>
	</p>
	<p><strong>Please make sure your datasource is created and you modify the transfer.xml</strong></p>
	]]></body>
</ide>
</response>

