<cfscript>
if( NOT structKeyExists(data.event.ide.projectView,"server") ){
	writeDump("Server not active in this project. Please activate this first in the project properties");abort;
}
serverInfo 	= data.event.ide.projectView.server.XMLAttributes;
filePath   	= replace(data.event.ide.projectView.resource.xmlAttributes.path,"\","/","all");
rootURL 	= replaceNoCase( filePath, replace(serverInfo.wwwroot,"\","/","all"),"") & "/index.cfm";
</cfscript>
<cfheader name="Content-Type" value="text/xml">
<cfoutput> 
<response showresponse="true"> 
<ide url="http://#serverInfo.hostName#:#serverInfo.port#/#rootURL#?debugpanel=cache" >
	<view id="cbox_cachebox_monitor" title="ColdBox CacheBox Monitor" icon="includes/images/coldbox_logo.jpg" />
</ide> 
</response> 
</cfoutput>