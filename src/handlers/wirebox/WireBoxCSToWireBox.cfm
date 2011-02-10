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
csFile = data.event.ide.projectview.resource.XMLAttributes.path;
converter = createObject("component","coldboxExtension.model.util.CSToWireBox").init();
// start conversion
results = converter.convert(csFile);
</cfscript>

<!--- Display --->
<cfheader name="Content-Type" value="text/xml">  
<cfoutput>
<response status="success" showresponse="true">  
<ide>  
	<dialog width="600" height="600" title="WireBox ColdSpring Converter" image="includes/images/ColdBox_Icon.png"/>  
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
			</cfif>
		</body>
	</html>
	]]> 
	</body> 
</ide>
</response>
</cfoutput>
