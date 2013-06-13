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
// Get entries
forgeBox = createObject("component","coldboxExtension.model.util.ForgeBox").init();
entries = forgeBox.getEntries(typeSlug=inputStruct.category,orderBy=inputStruct.orderBy);

// Destination Dir
updateURL 		= controller.getUtility().getCurrentURL(removeTemplate=true) & "ForgeBoxInstaller.cfm";
destinationDir 	= data.event.ide.projectview.resource.xmlAttributes.path;
</cfscript>
<!--- Output --->
<cfheader name="Content-Type" value="text/xml">  
<cfoutput> 
<response showresponse="true"> 
<ide> 
<dialog width="850" height="600" title="ColdBox ForgeBox Category Installer" image="includes/images/ColdBox_Icon.png" />  
<body> 
<![CDATA[ 
<html>
<head>
	<base href="#controller.getBaseURL()#" />
	
	<link href="includes/css/styles.css" type="text/css" rel="stylesheet">
	<script type="text/javascript" src="includes/js/jquery.latest.min.js"></script>
		
	<script language="javascript">
	function onSubmitForm(cRow){
		document.getElementById('installNow'+cRow).style.display = "block";
		document.getElementById('updateButton'+cRow).disabled = true;
	}
	</script>
	
</head>
<body>
	<h2>ForgeBox #inputStruct.category# (#entries.recordCount# Records Found)</h2>
	<p>Showing <strong>#inputStruct.category#</strong> ordered by <strong>#inputStruct.orderBy#</strong></p>
	<cfif entries.recordcount>
	<table class="tablelisting" width="99%" align="center">
		<thead>
			<tr>
				<th>Entry</th>
				<th>Author</th>
				<th>ColdBox</th>
				<th>Stats</th>
				<th>Install</th>
			</tr>
		</thead>
		<tbody>
			<cfloop query="entries">
				<tr>
					<td>
						<strong>#entries.title#</strong><br/>
						Version: #entries.version#<br/>
						#entries.summary#
					</td>
					<td width="150">
						#entries.fname# #entries.lname#
					</td>
					<td>#entries.coldboxVersion#</td>
					<td width="150">
						<strong>Downloads</strong> 	: #numberFormat(entries.hits)# <br/>
						<strong>Hits</strong> 		: #numberFormat(entries.hits)# <br/>
						<strong>Rating</strong> 	: #numberFormat(entries.entryrating,"_")#/5 <br/>
						<strong>Updated</strong> 	: <cfif isDate( entries.updatedate )>#dateFormat(entries.updatedate,"mm/dd/yyyy")#<cfelse># entries.updateDate #</cfif>
					</td>
					<td width="75">
						<form name="updateForm#entries.currentRow#" id="updateForm#entries.currentRow#" 
							  action="#updateURL#" method="POST" onsubmit="onSubmitForm(#entries.currentRow#)">
							<input type="hidden" name="destinationDir" value="#destinationDir#" />
							<input type="hidden" name="downloadFile"   value="#entries.downloadURL#" />
							<input type="hidden" name="slug"  		   value="#entries.slug#" />
							<input type="hidden" name="projectName"	   value="#controller.getProjectInfo().projectName#" />
							<input type="hidden" name="callBackURL"	   value="#controller.getCallBackURL()#" />
							
							<div class="align-center">
								<input id="updateButton#entries.currentRow#" type="submit" value="Install"/>
							</div>
							
							<div id="installNow#entries.currentRow#" style="display:none" class="align-center">
								<img src="includes/images/ajax-loader-horizontal.gif" alt=""> Installing Please Wait...
							</div>
						</form>
					</td>
				</tr>
			</cfloop>
		<tbody>
	</table>
	<cfelse>
	<div class="messagebox">No entries found!</div>
	</cfif>
</body>
</html>
]]> 
</body>
</ide> 
</response> 
</cfoutput>