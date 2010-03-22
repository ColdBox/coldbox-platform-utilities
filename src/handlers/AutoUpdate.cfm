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
	forgeBox = createObject("component","util.ForgeBox").init();
	// Install the Update
	results = forgeBox.install(downloadURL=form.downloadFile,destinationDir=form.destinationDir);
</cfscript>
<cfoutput>
<style type="text/css">
.messagebox{
	border:solid 1px ##CB2026;
	background:##F6CBCA 8px 6px no-repeat;
	color:##CB2026;
	padding:4px;
	text-align:center;
}
.consoleLog{
	border:2px solid ##eaeaea;
	padding:5px;
	font-size:12px;
	font-family: courier;
	background-color:black;
	color:##66E10D	
}
</style>

<cfif results.error>
<div class="messagebox">Error Installing Update, please see log below!</div>
<cfelse>
<h2>Update Installed Successfully</h2>
</cfif>

<p><strong>Install Log</strong><p>

<div class="consoleLog">
#results.logInfo#
</div>
</cfoutput>
