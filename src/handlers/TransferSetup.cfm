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
	<ide handlerfile="TransferGenerator.cfm"> 
		<dialog width="500" height="400" title="ColdBox Transfer ORM Configurator" image="includes/images/ColdBox_Icon.png">  
			<input name="dsnName" label="Datasource Name" required="true"  type="string" 
				   tooltip="Enter the name of the datasource to connect to"
				   helpmessage="Enter the name of the datasource to connect to" />
			<input name="dsnAlias" label="Datasource Alias" required="true"  type="string" 
				   tooltip="The alias for this datasource"
				   helpmessage="The alias for this datasource" />
			<input name="dsnType" label="Datasource Type" required="false"  type="list" 
				   tooltip="The database type"
				   helpmessage="The database type used for metadata purposes">
				<option value="mssql" />
				<option value="mysql" />
				<option value="mysql4" />
				<option value="postgresql" />
				<option value="oracle" />
				<option value="db2" />				
			</input>
			<input name="loadBeanInjector" label="Load Decorator Injector" type="boolean" checked="true"
				   tooltip="Load the Transfer Decorator Injector"
				   helpmessage="Load the Transfer Decorator Injector"
				   />
			<input name="diSetterInjection" label="Decorator Injector: Enable Setter Injections" type="boolean" 
				   checked="false" tooltip="Enable setter injection in the decorator injector"
				   helpmessage="Enable setter injection in the decorator injector"/>
			<input name="diStopRecursion" label="Decorator Injector: Stop Recursion Classes" type="string" 
				   default="" tooltip="The list of classes to stop recursion on (comma-delimmited)"
				   helpmessage="The list of classes to stop recursion on (comma-delimmited)"/>
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
				Setup the Transfer Loader Interceptor in the programmatic configuration manually.
			</div>
		</body>
	</html>
	]]></body>
</ide>
</response>
</cfif> 
</cfoutput>
 