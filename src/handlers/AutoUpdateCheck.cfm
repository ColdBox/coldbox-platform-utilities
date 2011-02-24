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
	// Get Extension Version
	xml = xmlParse(expandPath("../ide_config.xml"));
	extensionVersion = xml.application.version.xmlText;
	
	// Check for forgebox item
	forgeBox		 = createObject("component","coldboxExtension.model.util.ForgeBox").init();
	extensionEntry   = forgeBox.getEntry(slug="ColdBox-Platform-Utilities");
	
	// Check if versions are new.
	updateFound = controller.getUtility().isNewVersion(cVersion=extensionVersion,nVersion=extensionEntry.version);
	// AutoUpdate URL
	updateURL = controller.getUtility().getCurrentURL(removeTemplate=true) & "AutoUpdate.cfm";
	// Destination Dir
	destinationDir = controller.getExtensionLocation();
</cfscript>


<!--- Output --->
<cfheader name="Content-Type" value="text/xml">  
<cfoutput> 
<response showresponse="true"> 
<ide> 
<dialog width="600" height="500" title="ColdBox Extension Auto Update" image="includes/images/ColdBox_Icon.png" />  
<body> 
<![CDATA[ 
<html>
<head>
	<base href="#controller.getBaseURL()#" />
	
	<link href="includes/css/styles.css" type="text/css" rel="stylesheet">
	<script type="text/javascript" src="includes/js/jquery.latest.min.js"></script>
		
	<script language="javascript">
	function onSubmitForm(){
		document.getElementById('installNow').style.display = "block";
		document.getElementById('updateButton').disabled = true;
	}
	</script>
	
</head>
<body>
	<p>Checking if there is a newer version of this extension in the
	ColdBox ForgeBox Repository...
	<ul>
		<li>Your Version is: <b>#extensionVersion#</b></li>
		<li>Current Version is: <b>#extensionEntry.version#</b></li>
	</ul> 
	
	<cfif updateFound>
		<form name="updateForm" id="updateForm" action="#updateURL#" method="POST" onsubmit="onSubmitForm()">
		<input type="hidden" name="destinationDir" value="#destinationDir#" />
		<input type="hidden" name="downloadFile"   value="#extensionEntry.downloadURL#" />
		
		<div class="messagebox-green">
			New Extension Version Found!
			<p class="align-center"><input id="updateButton" type="submit" value="Update Now!"/></p>
		</div>
	
		<div id="installNow" style="display:none" class="align-center">
			<img src="includes/images/ajax-loader-horizontal.gif" alt=""> Installing Please Wait...
		</div>
		
		<p><strong>Version Changelog</strong><p>
		<div class="consoleLog">
			#extensionEntry.changelog#
		</div>
	</form>
	<cfelse>
		<div class="messagebox">You have the latest version installed!</div>
	</cfif>
</body>
</html>
]]> 
</body>
</ide> 
</response> 
</cfoutput>

