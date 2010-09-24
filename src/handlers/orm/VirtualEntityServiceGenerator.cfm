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
// Expand Location 
expandLocation	= data.event.ide.projectview.resource.xmlAttributes.path;
serviceLocation = expandLocation & "/#inputStruct.entityName#Service.cfc";

// Read template
serviceContent = fileRead( ExpandPath('../../') & "/templates/orm/VirtualEntityService.txt" );
// Text Replacements
serviceContent = replaceNoCase( serviceContent, "|entityName|", inputStruct.EntityName, "all");
serviceContent = replaceNoCase( serviceContent, "|QueryCaching|", inputStruct.QueryCaching, "all");
serviceContent = replaceNoCase( serviceContent, "|CacheRegion|", inputStruct.CacheRegion, "all");
serviceContent = replaceNoCase( serviceContent, "|serviceName|", inputStruct.entityName & "Service", "all");
serviceContent = replaceNoCase( serviceContent, "|eventHandling|", inputStruct.EventHandling, "all");
// Write it out
fileWrite(serviceLocation, serviceContent);
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
			    <param key="filename" value="#serviceLocation#" />
			</params>
		</command>
	</commands>
	<dialog width="600" height="350" title="ColdBox Virtual Entity Service Wizard" image="includes/images/ColdBox_Icon.png" />  
	<body><![CDATA[
	<html>
		<head>
			<base href="#controller.getBaseURL()#" />
			<link href="includes/css/styles.css" type="text/css" rel="stylesheet">
			<script type="text/javascript" src="includes/js/jquery.latest.min.js"></script>
		</head>
		<body>
			<div class="messagebox-green">Generated New Virtual Entity Service!</div>
			<p>
			Generated new service called: #inputStruct.entityName#.cfc
			</p>
		</body>
	</html>	
	]]></body>
</ide>
</response>
</cfoutput>
