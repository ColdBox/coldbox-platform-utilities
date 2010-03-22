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
	forgeBox		 = createObject("component","util.ForgeBox").init();
	extensionEntry   = forgeBox.getEntry(slug="ColdBox-Platform-Utilities");
	
	// Check if versions are new.
	updateFound = request.utility.isNewVersion(cVersion=extensionVersion,nVersion=extensionEntry.version);
	
	// AutoUpdate URL
	updateURL = URLSessionFormat( request.utility.getCurrentURL(removeTemplate=true) & "AutoUpdate.cfm" );
	// Destination Dir
	destinationDir = request.extensionLocation;
</cfscript>


<!--- Output --->
<cfheader name="Content-Type" value="text/xml">  
<cfoutput> 
<response showresponse="true"> 
<ide > 
<dialog width="550" height="450" title="ColdBox Extension Auto Update" image="images/ColdBox_Icon.png" />  
<body> 
<![CDATA[ 
<script language="javascript">
function onSubmitForm(){
	document.getElementById('installNow').style.display = "block";
	document.getElementById('updateButton').disabled = true;
}
</script>
<style type="text/css">
.consoleLog{
	border:2px solid ##eaeaea;
	padding:5px;
	font-size:12px;
	font-family: courier;
	background-color:black;
	color:##66E10D	
}
</style>

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

<h2><span style="color:red">New Version Found!</span></h2>

<p><input id="updateButton" type="submit" value="Update Now!"/></p>

<div id="installNow" style="display:none">
<img src="#request.utility.getCurrentURL(removeTemplate=true)#/../../images/ajax-loader-horizontal.gif" alt=""> Installing Please Wait...
</div>


<p><strong>Version Changelog</strong><p>
<div class="consoleLog">
#extensionEntry.changelog#
</div>
</form>
</cfif>
]]> 
</body>
</ide> 
</response> 
</cfoutput>

