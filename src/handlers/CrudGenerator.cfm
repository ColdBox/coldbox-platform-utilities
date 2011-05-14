<!-----------------------------------------------------------------------
********************************************************************************
Copyright Since 2005 ColdBox Framework by Luis Majano and Ortus Solutions, Corp
www.coldboxframework.com | www.luismajano.com | www.ortussolutions.com
********************************************************************************

Author      :	Sana Ullah & Luis Majano

All handlers receive the following:
- data 		  : The data parsed
- inputStruct : A parsed input structure
----------------------------------------------------------------------->
<cfscript>
	projectname		= data.event.ide.projectview.xmlAttributes.projectname;
	// parse entity
	entityPath 		= data.event.ide.projectview.resource.XMLAttributes.path;
	entityContent 	= fileRead( entityPath );
	
	// property Map
	metadata = { properties = [], pk=""};
	
	// match properties
	props = reMatchNoCase("((cf)?property([^\>|;])+)", entityContent);
	
	// build property maps
	if( arrayLen(props) ){
		for(x=1; x lte arrayLen(props); x++ ){
			// convert string to property representation
			thisProperty = controller.getUtility().entityPropertyToStruct(props[x]);
			// store the pk for convenience
			if( compareNoCase( thisProperty.fieldType, "id") EQ 0){ metadata.pk = thisProperty.name; }
			
			// Store only persistable columns
			if( thisProperty.isPersistable ){
				arrayAppend( metadata.properties, thisProperty );
			}
		}
		
		// Read Handler Content
		hContent = fileRead("#ExpandPath('../')#/templates/crud/HandlerContent.txt");
		// Token replacement
		hContent = replacenocase(hContent, "|entity|", inputStruct.name, "all");
		hContent = replacenocase(hContent, "|entityPlural|", inputStruct.pluralName, "all");
		hContent = replacenocase(hContent, "|pk|", metadata.pk, "all");
		// Write Out Handler
		fileWrite( inputStruct.HandlersDirectory & "/#inputStruct.pluralname#.cfc", hContent);
		
		// Write Out The Views
		if( NOT directoryExists(inputStruct.viewsDirectory & "/#inputStruct.pluralName#") ){
			controller.getUtility().createDirectory( inputStruct.viewsDirectory & "/#inputStruct.pluralName#" );
		}
		views = ["edit","editor","new"];
		for(x=1; x lte ArrayLen(views); x++){
			vContent = fileRead("#ExpandPath('../')#/templates/crud/#views[x]#.txt");
			vContent = replacenocase(vContent, "|entity|", inputStruct.name, "all");
			vContent = replacenocase(vContent, "|entityPlural|", inputStruct.pluralName, "all");
			fileWrite( inputStruct.viewsDirectory & "/#inputStruct.pluralName#/#views[x]#.cfm", vContent);
		}
		
		// Build table output for index
		savecontent variable="tableData"{
			include "../templates/crud/table.cfm";
		}
		tableData = replaceNoCase(tableData, "%cf", "<cf", "all");
		tableData = replaceNoCase(tableData, "%/cf", "</cf", "all");
		vContent = fileRead("#ExpandPath('../')#/templates/crud/index.txt");
		vContent = replacenocase(vContent, "|entity|", inputStruct.name, "all");
		vContent = replacenocase(vContent, "|entityPlural|", inputStruct.pluralName, "all");
		vContent = replacenocase(vContent, "|tableListing|", tableData, "all");
		fileWrite( inputStruct.viewsDirectory & "/#inputStruct.pluralName#/index.cfm", vContent);
	
	}

</cfscript>

<cfheader name="Content-Type" value="text/xml">  
<cfoutput>
<response status="success" showresponse="true">  
<ide> 
	<commands>
		<command type="refreshproject">
			<params>
			    <param key="projectname" value="#projectname#" />
			</params>
		</command>
		<cfif arrayLen(props)>
		<command type="openfile">
			<params>
				<param key="filename" value="#inputStruct.HandlersDirectory#/#inputStruct.pluralName#.cfc" />
			</params>
		</command>
		</cfif>
	</commands>
	<!--- no len --->
	<cfif NOT arrayLen(props)>
	<dialog width="600" height="350" title="ColdBox Application Generator Wizard" image="includes/images/ColdBox_Icon.png"/>  
	<body><![CDATA[
	<html>
		<head>
			<base href="#controller.getBaseURL()#" />
			<link href="includes/css/styles.css" type="text/css" rel="stylesheet">
			<script type="text/javascript" src="includes/js/jquery.latest.min.js"></script>
		</head>
		<body>
			<div class="messagebox">No properties found on component. Nothing Generated</div>
		</body>
	</html>	
	]]></body>
	</cfif>
</ide>
</response>
</cfoutput>