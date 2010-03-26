<!-----------------------------------------------------------------------
********************************************************************************
Copyright Since 2005 ColdBox Framework by Luis Majano and Ortus Solutions, Corp
www.coldboxframework.com | www.luismajano.com | www.ortussolutions.com
********************************************************************************

Author      :	 Sana Ullah & Luis Majano
Date        :	08/01/2009
----------------------------------------------------------------------->
<cfscript>
destinationLocation = data.event.ide.projectview.resource.xmlAttributes.path & "/";
</cfscript>

<cfheader name="Content-Type" value="text/xml">  
<cfoutput>  
<cfif fileExists(destinationLocation & "coldbox.xml.cfm")>
<response status="success" type="default">  
	<ide handlerfile="EnvironmentGenerator.cfm"> 
		<dialog width="450" height="250" title="ColdBox Environment Control Configurator" image="includes/images/ColdBox_Icon.png">  
			
			<input name="envName" label="Name of environment" type="string" 
				   tooltip="The unique name for this environment" required="true"
			/>
			<input name="envURLs" label="URL's for environment (comma-delimmited)" type="string" 
				   tooltip="The url parts that identify this environment. (comma-delimmited)" required="true"
			/>
			
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
			<base href="#request.baseURL#" />
			<link href="includes/css/styles.css" type="text/css" rel="stylesheet">
			<script type="text/javascript" src="includes/js/jquery.latest.min.js"></script>
		</head>
		<body>
			<div class="messagebox">
				Cannot use the Environment control interceptor on the programmatic configuration object
				 <strong>Coldbox.cfc</strong> as the programmatic configuration ALREADY has environment control built in.
			</div>
		</body>
	</html>
	]]></body>
</ide>
</response>
</cfif>
</cfoutput>