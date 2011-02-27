<!-----------------------------------------------------------------------
********************************************************************************
Copyright Since 2005 ColdBox Framework by Luis Majano and Ortus Solutions, Corp
www.coldboxframework.com | www.luismajano.com | www.ortussolutions.com
********************************************************************************

Author      :	Brad Wood
Date        :	02/27/2010

All handlers receive the following:
- data 		  : The data parsed
- inputStruct : A parsed input structure
----------------------------------------------------------------------->
<cfscript>
// MMFile
mmFile 	= data.event.ide.projectview.resource.XMLAttributes.path;
wbFile	= getDirectoryFromPath(mmFile) & "/WireBox.cfc";
converter 		= createObject("component","coldboxExtension.model.util.MMToWireBox").init();
// start conversion
results = converter.convert(mmFile);
// Create WireBox Binder
if( NOT len(results.errorMessages) ){
	template = fileRead("#ExpandPath('../../')#templates/wirebox/WireBox.txt");
	template = replacenocase(template,"|mapBindings|",results.data);
	fileWrite(wbFile, template);
}
</cfscript>

<!--- Display --->
<cfheader name="Content-Type" value="text/xml">  
<cfoutput>
<response status="success" showresponse="true">  
<ide> 
	<cfif not len(results.errorMessages)> 
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
	</cfif>
	<dialog width="600" height="250" title="WireBox Model Mapping Converter" image="includes/images/ColdBox_Icon.png"/>  
	<body> 
	<![CDATA[ 
	<html>
		<head>
			<base href="#controller.getBaseURL()#" />
			<link href="includes/css/styles.css" type="text/css" rel="stylesheet">
			<script type="text/javascript" src="includes/js/jquery.latest.min.js"></script>
		</head>
		<body>
			<cfif len(results.errorMessages)>
				<div class="messagebox">
				#results.errorMessages#
				</div>
			<cfelse>
				<div class="messagebox-green">
					Model Mapping To WireBox conversion finalized! We have created a WireBox 
					configuration binder for you and opened it!
				</div>
			</cfif>
		</body>
	</html>
	]]> 
	</body> 
</ide>
</response>
</cfoutput>
