<!-----------------------------------------------------------------------
********************************************************************************
Copyright Since 2005 ColdBox Framework by Luis Majano and Ortus Solutions, Corp
www.coldboxframework.com | www.luismajano.com | www.ortussolutions.com
********************************************************************************

Author      :	Sana Ullah & Luis Majano
Date        :	08/01/2009

All handlers receive the following:
- data 		  : The data parsed
- inputStruct : A parsed input structure
----------------------------------------------------------------------->

<cfscript>
expandLocation	= data.event.ide.projectview.resource.xmlAttributes.path;
objectName		= inputstruct.Name;

// Read template
content = fileRead("#ExpandPath('../')#/templates/ORMEventHandler.txt");

// Replacements
content = replaceNoCase(content,"|injector|",inputStruct.Injector,"all");
content = replaceNoCase(content,"|setterInjection|",inputStruct.setterInjection,"all");
content = replaceNoCase(content,"|stopRecursion|",inputStruct.stopRecursion,"all");
content = replaceNoCase(content,"|injectorInclude|",inputStruct.injectorInclude,"all");
content = replaceNoCase(content,"|InjectorExclude|",inputStruct.InjectorExclude,"all");

// Write it out
fileWrite("#expandLocation#/#objectName#.cfc", content);
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
			    <param key="filename" value="#expandLocation#/#objectName#.cfc" />
			</params>
		</command>
		<cfif fileExists(data.event.ide.projectview.xmlAttributes.projectLocation & "/Application.cfc")>
		<command type="openfile">
			<params>
			    <param key="filename" value="#data.event.ide.projectview.xmlAttributes.projectLocation#/Application.cfc" />
			</params>
		</command>
		</cfif>
	</commands>
	<dialog width="600" height="600" title="ColdBox ORM Event Handler Wizard" image="includes/images/ColdBox_Icon.png"/>  
	<body>
<![CDATA[
<html>
	<head>
		<base href="#request.baseURL#" />
		<link href="includes/css/styles.css" type="text/css" rel="stylesheet">
		<script type="text/javascript" src="includes/js/jquery.latest.min.js"></script>
	</head>
	<body>
		<div class="messagebox-green">ORM Event Handler Created!</div>
		<h2>Important</h2>
		<p>Please add the following code to your Application.cfc in the ORMSettings configuration structure in order to enable hibernate event handling.
		Please also update the path to the created newly created ORM Event Handler below:
		</p>
		
		<code>
		<pre>
this.ormSettings = {
	eventhandling = true,
	eventhandler = "PATH_HERE.#objectName#"
};
		</pre>
		</code>
	</body>
</html>	
	]]>
	</body>
</ide>
</response>
</cfoutput>

