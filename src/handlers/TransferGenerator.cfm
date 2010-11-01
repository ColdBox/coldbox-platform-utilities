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
templatesLocation = expandPath('../templates/transfer') & "/";

// Move new transfer.xml
fileCopy(templatesLocation & "transfer.xml.cfm", destinationLocation);

// Create definitions folder
if( NOT directoryExists(destinationLocation & "definitions") ){
	controller.getUtility().createDirectory(destinationLocation & "definitions");
}

// Add interceptor to XML
configXML = xmlParse(configLocation);
// Create interceptor element
varName = xmlElemNew(configXML,"VariableName");
varName.XMLText = "";
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
			    <param key="filename" value="#destinationLocation#transfer.xml.cfm" />
			</params>
		</command>
		<command type="openfile">
			<params>
			    <param key="filename" value="#configLocation#" />
			</params>
		</command>
	</commands>
	<dialog width="550" height="450" title="ColdBox Deploy Tag Configurator" image="includes/images/ColdBox_Icon.png"/>  
	<body><![CDATA[
	<html>
		<head>
			<base href="#controller.getBaseURL()#" />
			<link href="includes/css/styles.css" type="text/css" rel="stylesheet">
			<script type="text/javascript" src="includes/js/jquery.latest.min.js"></script>
		</head>
		<body>
			<div class="messagebox-green">Transfer ORM Configured!</div>
			
			<h2>Install Log</h2>
			<div class="consoleLog">
				<p>
				Transfer XML file created at : <em>config/transfer.xml.cfm</em> <br/>
				Transfer definitioins folder created at : <em>config/definitions</em> <br/>
				Datasource added to config and interceptor configured. <br/>
				</p>
				<p><strong>Please make sure your datasource is created and you modify the transfer.xml</strong></p>
			</div>
		</body>
	</html>	
	
	]]></body>
</ide>
</response>
</cfoutput>

