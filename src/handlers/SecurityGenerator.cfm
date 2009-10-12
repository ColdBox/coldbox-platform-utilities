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
templatesLocation = expandPath('../templates/security') & "/";

// Move security access file
fileCopy(templatesLocation & "security.xml.cfm", destinationLocation);

// Generate Validator?
if( inputStruct.generateValidator ){
	scriptPrefix = "";
	// Full script CFC?
	if( inputStruct.Script ){ scriptPrefix = "Script"; }
	// Copy template to model folder
	fileCopy(templatesLocation & "UserValidatorContent#scriptPrefix#.txt", projectLocation & "model/UserValidator.cfc");
}

// Add interceptor to XML
configXML = xmlParse(configLocation);

// Create interceptor element
interceptor = xmlElemNew(configXML,"Interceptor");
interceptor.XMLAttributes["class"] = "coldbox.system.interceptors.Security";
// Rules Source
interceptor.XMLChildren[1] = xmlElemNew(configXML,"Property");
interceptor.XMLChildren[1].XMLAttributes["name"] = "rulesSource";
interceptor.XMLChildren[1].xmlText = "xml";
// Config File
interceptor.XMLChildren[2] = xmlElemNew(configXML,"Property");
interceptor.XMLChildren[2].XMLAttributes["name"] = "rulesFile";
interceptor.XMLChildren[2].xmlText = "config/security.xml.cfm";
// Regex
interceptor.XMLChildren[3] = xmlElemNew(configXML,"Property");
interceptor.XMLChildren[3].XMLAttributes["name"] = "useRegex";
interceptor.XMLChildren[3].xmlText = inputStruct.useRegex;
// Use Routes
interceptor.XMLChildren[4] = xmlElemNew(configXML,"Property");
interceptor.XMLChildren[4].XMLAttributes["name"] = "useRoutes";
interceptor.XMLChildren[4].xmlText = inputStruct.useRoutes;

if( inputStruct.generateValidator ){
	// Deploy Command Object
	interceptor.XMLChildren[5] = xmlElemNew(configXML,"Property");
	interceptor.XMLChildren[5].XMLAttributes["name"] = "validatorModel";
	interceptor.XMLChildren[5].xmlText = "UserValidator";
}
// Add to interceptors Array
arrayAppend(configXML.config.interceptors.xmlChildren,interceptor);
// Write it out
fileWrite(configLocation, request.utility.prettifyXML(configXML));
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
			    <param key="filename" value="#destinationLocation#security.xml.cfm" />
			</params>
		</command>
		<cfif inputStruct.generateValidator>
		<command type="openfile">
			<params>
			    <param key="filename" value="#projectLocation#model\UserValidator.cfc" />
			</params>
		</command>
		</cfif>
	</commands>
	<dialog width="550" height="450" title="ColdBox Security Configurator" image="images/ColdBox_Icon.png"/>  
	<body><![CDATA[
	<h2>Security Interceptor Configured!</h2>
	<p>
		Security Rules File Created at : config/security.xml.cfm	
		<cfif inputStruct.generateValidator>
		<br/>
		Custom User Validator created in your model folder as <strong>UserValidator.cfc</strong>
		</cfif>
	</p>
	]]></body>
</ide>
</response>
</cfoutput>

