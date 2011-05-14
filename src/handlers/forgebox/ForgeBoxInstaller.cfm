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
	results  = { 
		error = false, logInfo = "" 
	};
	
	// Get Entry information
	expandLocation  = form.destinationDir;
	downloadURL 	= form.downloadFile;
	entry			= forgeBox.getEntry(slug=form.slug);
	
	// Install Entry if found?
	if( NOT structIsEmpty(entry) ){
		results = forgeBox.install(downloadURL=downloadURL,destinationDir=expandLocation);
	}
	else{
		results.error = true;
		results.logInfo = "The entry requested was not found";
	}
	
	// refresh project
	controller.refreshProject(form.projectName,form.callBackURL);
</cfscript>

<!--- instructions --->
<cfsavecontent variable="instructions">
<cfoutput>
<html>
<head>
	<base href="#controller.getBaseURL()#" />
	<link href="includes/css/styles.css" type="text/css" rel="stylesheet">
	<script type="text/javascript" src="includes/js/jquery.latest.min.js"></script>
</head>
<body>
	<cfif results.error>
		<div class="messagebox">Error Installing Entry please see log below!</div>
	</cfif>

	<h2>Install Log</h2>

	<div class="consoleLog">
	#results.logInfo#
	</div>
	
	<cfif NOT structIsEmpty(entry)>
		<h2>Description</h2>
		<p>#entry.description#</p>
		
		<cfif len(entry.installInstructions)>
			<h2>Install Instructions</h2>
			<p>#entry.installinstructions#</p>
		</cfif>
		
		<cfif len(entry.changelog)>
			<h2>Changelog</h2>
			<p>#entry.changelog#</p>
		</cfif>
	</cfif>
	
	<br/><br/>
</body>
</html>
</cfoutput>
</cfsavecontent>

<!--- Write Out Instructions --->
<cfif NOT results.error>
	<cfset fileWrite(expandLocation & "/#form.slug#-instructions.html", instructions)>
</cfif>

<!--- Output --->
<cfoutput>#instructions#</cfoutput>