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
// CSFile
wbFile		= data.event.ide.projectview.resource.xmlAttributes.path & "/WireBox.cfc";
template	= fileRead("#ExpandPath('../../')#templates/wirebox/WireBox.txt");
template 	= replacenocase(template,"|mapBindings|","");
fileWrite(wbFile, template);
</cfscript>

<!--- Display --->
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
			    <param key="filename" value="#wbFile#" />
			</params>
		</command>
	</commands>
	<dialog width="600" height="250" title="WireBox ColdSpring Converter" image="includes/images/ColdBox_Icon.png"/>  
	<body> 
	<![CDATA[ 
	<html>
		<head>
			<base href="#controller.getBaseURL()#" />
			<link href="includes/css/styles.css" type="text/css" rel="stylesheet">
			<script type="text/javascript" src="includes/js/jquery.latest.min.js"></script>
		</head>
		<body>
			<div class="messagebox-green">
			We have created a WireBox configuration binder for you and opened it!
			</div>
		</body>
	</html>
	]]> 
	</body> 
</ide>
</response>
</cfoutput>
