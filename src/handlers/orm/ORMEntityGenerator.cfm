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
expandLocation	= data.event.ide.projectview.resource.xmlAttributes.path;

// script
scriptPrefix = "";
if( inputStruct.script ){ scriptPrefix = "Script"; }

// Read in template
entityContent = fileRead( ExpandPath("/coldboxExtension/templates/orm/Entity#scriptPrefix#.txt") );
// entityName
entityContent = replaceNoCase( entityContent, "|entityName|", inputStruct.name, "all");
// table
if( NOT len(inputStruct.table) ){
	inputStruct.table = inputStruct.name;
}
entityContent = replaceNoCase( entityContent, "|table|", inputStruct.table,"all" );

// Active Entity
if( inputStruct.activeEntity ){
	entityContent = replaceNoCase( entityContent, "|activeEntity|",' extends="coldbox.system.orm.hibernate.ActiveEntity"',"all" );
	entityContent = replaceNoCase( entityContent, "|activeEntityInit|",'super.init(useQueryCaching="false");',"all" );
}
else{
	entityContent = replaceNoCase( entityContent, "|activeEntity|","","all" );
	entityContent = replaceNoCase( entityContent, "|activeEntityInit|","","all" );
}

// Primary key
entityContent = replaceNoCase( entityContent, "|primaryKey|", inputStruct.primaryKey,"all" );
// Primary Key Column
if( NOT len(inputStruct.primaryKeyColumn) ){
	inputStruct.primaryKeyColumn = inputStruct.primaryKey;
}
entityContent = replaceNoCase( entityContent, "|primaryKeyColumn|", inputStruct.primaryKeyColumn,"all" );
// generator
entityContent = replaceNoCase( entityContent, "|generator|", inputStruct.primaryKeyGenerator,"all" );

// Properties
properties 	= listToArray( inputStruct.properties );
buffer 		= createObject("java","java.lang.StringBuffer").init();
for(x=1; x lte arrayLen(properties); x++){

	propName = getToken( trim(properties[x]), 1, ":");
	propType = getToken( trim(properties[x]), 2, ":");
	if( NOT len(propType) ){ propType = "string"; }

	if( inputStruct.script ){
		buffer.append('property name="#propName#" ormtype="#propType#";#chr(13) & chr(9)#');
	}
	else{
		buffer.append('<cfproperty name="#propName#" ormtype="#propType#">#chr(13) & chr(9)#');
	}
}
entityContent = replaceNoCase( entityContent, "|properties|", buffer.toString() );

// write it out.
fileWrite( expandLocation & "/#inputStruct.name#.cfc", entityContent );
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
			    <param key="filename" value="#expandLocation#/#inputStruct.name#.cfc" />
			</params>
		</command>
	</commands>
	<dialog width="550" height="350" title="ColdFusion ORM Entity Wizard" image="includes/images/ColdBox_Icon.png"/>
	<body><![CDATA[
	<html>
		<head>
			<base href="#controller.getBaseURL()#" />
			<link href="includes/css/styles.css" type="text/css" rel="stylesheet">
			<script type="text/javascript" src="includes/js/jquery.latest.min.js"></script>
		</head>
		<body>
			<div class="messagebox-green">Generated New ORM Entity!</div>
			<p>
			Generated new entity called: #inputStruct.name#.cfc<br/>
			</p>
		</body>
	</html>
	]]></body>
</ide>
</response>
</cfoutput>
