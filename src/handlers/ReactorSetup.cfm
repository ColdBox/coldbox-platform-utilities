<!-----------------------------------------------------------------------
Author 	 :	Sana Ullah
Date     :	August 1, 2009
Description :
---------------------------------------------------------------------->
<cfscript>
destinationLocation = data.event.ide.projectview.resource.xmlAttributes.path & "/";
</cfscript>

<cfheader name="Content-Type" value="text/xml">  
<cfoutput>  
<cfif fileExists(destinationLocation & "coldbox.xml.cfm")>
<response status="success" type="default">  
	<ide handlerfile="ReactorGenerator.cfm"> 
		<dialog width="550" height="400" title="ColdBox Reactor ORM Configurator" image="includes/images/ColdBox_Icon.png">  
			<input name="projectName" label="Project Name" required="true"  type="string" 
				   tooltip="The reactor project name"
				   helpmessage="The database type used for metadata purposes" />
			<input name="dsnName" label="Datasource Name" required="true"  type="string" 
				   tooltip="Enter the name of the datasource to connect to"
				   helpmessage="Enter the name of the datasource to connect to" />
			<input name="dsnAlias" label="Datasource Alias" required="true"  type="string" 
				   tooltip="The alias for this datasource"
				   helpmessage="The alias for this datasource" />
			<input name="dsnType" label="Datasource Type" required="true"  type="list" 
				   tooltip="The database type"
				   helpmessage="The database type used for metadata purposes">
				<option value="mssql" />
				<option value="mysql" />
				<option value="mysql4" />
				<option value="postgresql" />
				<option value="oracle" />
				<option value="db2" />				
			</input>
				   
		</dialog>
	</ide>
</response>  
<cfelse>
<response status="success" type="default" showresponse="true">  
<ide> 
<dialog width="550" height="250" title="ColdBox Environment Control Configurator" image="includes/images/ColdBox_Icon.png"/>  
	<body><![CDATA[
	<html>
		<head>
			<base href="#controller.getBaseURL()#" />
			<link href="includes/css/styles.css" type="text/css" rel="stylesheet">
			<script type="text/javascript" src="includes/js/jquery.latest.min.js"></script>
		</head>
		<body>
			<div class="messagebox">
				Setup the Reactor Loader Interceptor in the programmatic configuration manually.
			</div>
		</body>
	</html>
	]]></body>
</ide>
</response>
</cfif>
</cfoutput>
 