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
// CSFile
wbFile	 = data.event.ide.projectview.resource.xmlAttributes.path & "/CacheBox.cfc";
template = fileRead( "#ExpandPath('../../')#templates/cachebox/CacheBox.txt" );
fileWrite( wbFile, template );
</cfscript>

<!--- Display --->
<cfheader name="Content-Type" value="text/xml">
<cfoutput>
<response status="success" showresponse="true">
<ide>
	<commands>
		<command type="RefreshProject">
			<params>
			    <param key="projectname" value="#data.event.ide.projectview.xmlAttributes.projectname#" />
			</params>
		</command>
		<command type="openfile">
			<params>
			    <param key="filename" value="#wbFile#" />
			</params>
		</command>
	</commands>
</ide>
</response>
</cfoutput>