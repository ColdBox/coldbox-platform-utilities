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
projectLocation = data.event.ide.projectview.XMLAttributes.projectLocation & "/";
routesLocation = projectLocation & "config/Routes.cfm";
templatesLocation = expandPath('../templates/ses') & "/";

// Move rewrite engine
switch(inputStruct.rewriteEngine){
	case "mod_rewrite" : {
		copiedFile = ".htaccess";
		fileCopy(templatesLocation & ".htaccess", projectLocation);
		break;
	}
	case "ISAPI" : {
		copiedFile = "IsapiRewrite4.ini";
		fileCopy(templatesLocation & "IsapiRewrite4.ini", projectLocation);
		break;
	}
}
// Remove index.cfm from routes.cfm
routes = fileRead(routesLocation);
routes = replacenocase(routes,"index.cfm","","all");
fileWrite(routesLocation,routes);

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
			    <param key="filename" value="#routesLocation#" />
			</params>
		</command>
		<command type="openfile">
			<params>
			    <param key="filename" value="#projectLocation & copiedFile#" />
			</params>
		</command>
	</commands>
	<dialog width="550" height="450" title="ColdBox URL Rewrite Rules Created" image="images/ColdBox_Icon.png"/>  
	<body><![CDATA[
	<h2>Rewrite Rules File Created!</h2>
	<p>
	The <em>#inputStruct.rewriteEngine#</em> URL rewrite rules have been created in your root folder as
	<strong>#copiedFile#</strong>. <br/>
	Your <em>Routes.cfm</em> file has been modified to remove any <em>index.cfm</em> references.
	</p>
	]]></body>
</ide>
</cfoutput>
</response>

