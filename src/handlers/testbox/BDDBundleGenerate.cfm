<!-----------------------------------------------------------------------
********************************************************************************
Copyright Since 2005 ColdBox Framework by Luis Majano and Ortus Solutions, Corp
www.coldboxframework.com | www.luismajano.com | www.ortussolutions.com
********************************************************************************
Author      :	 Sana Ullah & Luis Majano
----------------------------------------------------------------------->
<cfscript>
// target + harness location
target = data.event.ide.projectview.resource.XMLAttributes.path & "/#inputStruct.bundlename#.cfc";
bddLocation = expandPath( "/cpu/templates/testbox/bdd.txt");
// generate it
fileCopy( bddLocation, target );
</cfscript>
<cfheader name="Content-Type" value="text/xml">
<cfoutput>
<response status="success" showresponse="false">
<ide>
	<commands>
		<command type="RefreshProject">
			<params>
			    <param key="projectname" value="#data.event.ide.projectview.xmlAttributes.projectname#" />
			</params>
		</command>
		<command type="openfile">
			<params>
				<param key="filename" value="#target#" />
			</params>
		</command>
	</commands>
</ide>
</cfoutput>
</response>

