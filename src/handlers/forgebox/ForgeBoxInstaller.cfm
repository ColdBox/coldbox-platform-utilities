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
	expandLocation	 = data.event.ide.projectview.resource.xmlAttributes.path;
	forgeBox		 = createObject("component","coldboxExtension.model.util.ForgeBox").init();
	entry		     = forgeBox.getEntry(slug=inputStruct.forgeBoxSlug);
	
	if( NOT structIsEmpty(entry) ){
		results = forgeBox.install(downloadURL=entry.downloadURL,destinationDir=expandLocation);
	}
	
</cfscript>

<!--- Output --->
<cfheader name="Content-Type" value="text/xml">  
<cfoutput>  
<response showresponse="true"> 
	<ide> 
		<dialog width="550" height="450" title="ColdBox ForgeBox Installer" image="includes/images/ColdBox_Icon.png" />  
		<body> 
		<![CDATA[ 
		<html>
		<head>
			<base href="#controller.getBaseURL()#" />
			<link href="includes/css/styles.css" type="text/css" rel="stylesheet">
			<script type="text/javascript" src="includes/js/jquery.latest.min.js"></script>
		</head>
		<body>
			<cfif structIsEmpty(entry)>
				<div class="messagebox">The slug: <strong>#inputStruct.forgeBoxSlug#</strong> cannot be found in the repository, please try again!</div>
			<cfelse>
			
				<cfif  results.error>
					<div class="messagebox">Error Intaling Entry please see log below!</div>
				<cfelse>
					<div class="messagebox-green">#entry.slug# Installed!</div>
				</cfif>
			
				<h2>Install Log</h2>
			
				<div class="consoleLog">
				#results.logInfo#
				</div>
				
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
				
				<br/><br/>
			</cfif>
		</body>
		</html>
		]]> 
		</body>
	</ide>
</response>  
</cfoutput> 

