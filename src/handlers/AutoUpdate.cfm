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
	forgeBox = createObject("component","coldboxExtension.model.util.ForgeBox").init();
	// Install the Update
	results = forgeBox.install(downloadURL=form.downloadFile,destinationDir=form.destinationDir);
</cfscript>
<cfoutput>
<html>
<head>
	<base href="#controller.getBaseURL()#" />
	
	<link href="includes/css/styles.css" type="text/css" rel="stylesheet">
	<script type="text/javascript" src="includes/js/jquery.latest.min.js"></script>
</head>
<body>
	<cfif results.error>
		<div class="messagebox">Error Installing Update, please see log below!</div>
	<cfelse>
		<div class="messagebox-green">
			Update Installed Successfully!
			<p>Please make sure that you reload the CFBuilder Extensions for the changes to take effect</p>
		</div>		
	</cfif>
	
	<h2>Install Log</h2>
	
	<div class="consoleLog">
	#results.logInfo#
	</div>
</body>
</html>
</cfoutput>
