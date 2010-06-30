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
configLocation 		= destinationLocation & "coldbox.xml.cfm";
projectLocation 	= data.event.ide.projectview.XMLAttributes.projectLocation & "/";
templatesLocation 	= expandPath('../templates/deploy') & "/";

// Move deploy tag and ANT script
fileCopy(templatesLocation & "_deploy.tag", destinationLocation);
fileCopy(templatesLocation & "deploy.xml", destinationLocation);

// Generate Command Object?
if( inputStruct.GenerateCommandObject ){
	scriptPrefix = "";
	// Full script CFC?
	if( inputStruct.Script ){ scriptPrefix = "Script"; }
	// Copy template to model folder
	fileCopy(templatesLocation & "CommandObjectContent#scriptPrefix#.txt", projectLocation & "model/DeployCommand.cfc");
}

// Add interceptor to XML if it exists
if( fileExists(configLocation) ){
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
		interceptor.XMLChildren[2].XMLAttributes["name"] = "deployCommandModel";
		interceptor.XMLChildren[2].xmlText = "DeployCommand";
	}
	// Add to interceptors Array
	arrayAppend(configXML.config.interceptors.xmlChildren,interceptor);
	// Write it out
	fileWrite(configLocation, controller.getUtility().prettifyXML(configXML));
}
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
		<cfif inputStruct.GenerateCommandObject>
		<command type="openfile">
			<params>
			    <param key="filename" value="#projectLocation#model/DeployCommand.cfc" />
			</params>
		</command>
		</cfif>
		<cfif fileExists(destinationLocation & "Coldbox.cfc")>
		<command type="openfile">
			<params>
			    <param key="filename" value="#destinationLocation#Coldbox.cfc" />
			</params>
		</command>
		</cfif>
	</commands>
	<dialog width="600" height="500" title="ColdBox Deploy Tag Configurator" image="includes/images/ColdBox_Icon.png"/>  
	<body><![CDATA[
	<html>
		<head>
			<base href="#controller.getBaseURL()#" />
			<link href="includes/css/styles.css" type="text/css" rel="stylesheet">
			<script type="text/javascript" src="includes/js/jquery.latest.min.js"></script>
		</head>
		<body>
			<div class="messagebox-green">
				Deploy Interceptor Configured!
			</div>
			
			<h2>Install Log</h2>
			<div class="consoleLog">
				Deploy tag created: <strong>config/_deploy.tag</strong> <br/>
				ANT Task created: <strong>config/deploy.xml</strong>	
				<cfif inputStruct.GenerateCommandObject>
					<br/>
					Deploy Command Object created in your model folder as <strong>DeployCommand.cfc</strong>
				</cfif>
				<cfif fileExists(configLocation) >
					Configuration file: <strong>#configLocation#</strong> updated with interceptor declaration
				</cfif>
			</div>			
			
			<cfif NOT fileExists(configLocation) >
				<div class="messagebox">
					You are using the programmatic Coldbox.cfc, so we will open it for you, so you can add
					the interceptor declaration.  You can use the generated code below:
				</div>
				
<code><pre>
interceptors = [
  { class="coldbox.system.interceptors.Deploy",
    properties = {
	  tagFile = "config/_deploy.tag",
	  deployCommandModel = "DeployCommand"
	}	
  }
]
</pre></code>
			
			</cfif>
				
		</body>
	</html>	
	]]></body>
</ide>
</response>
</cfoutput>
