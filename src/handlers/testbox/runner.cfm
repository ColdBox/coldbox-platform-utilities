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
	// target path
	runnerURL = controller.getTestBoxRunner();
</cfscript>
<!--- Output --->
<cfheader name="Content-Type" value="text/xml">
<cfoutput>
<response status="success" type="default">
	<ide handlerfile="testbox/runnerWindow.cfm">
		<dialog width="550" height="500" title="TestBox HTML Runner" image="includes/images/TestBoxLogoSolo.png">

			<input name="runnerURL" label="Runner"
				   tooltip="The HTML runner to execute"
				   type="string"
				   default="#runnerURL#" />

			<input name="bundles" label="Bundles"
				   tooltip="The bundle(s) paths to test, leave blank for runner to use defaults"
				   type="string"
				   checked="false" />

			<input name="directory" label="Directory"
				   tooltip="The directory instantiation path, leave blank for defaults"
				   type="string"
				   checked="false" />

			<input name="recurse" label="Recurse"
				   tooltip="Directory recursion"
				   type="Boolean"
				   checked="true" />

			<input name="reporter" label="Reporter" type="list" default="simple">
			<cfloop array="#controller.getUtility().getTestBoxReporters()#" index="i">
				<option value="#i#" />
			</cfloop>
			</input>

			<input name="createWindow" label="Create Window"
				   tooltip="Whether it just runs and presents results or we create a window in the IDE"
				   type="Boolean"
				   checked="false" />

			<input name="labels" label="Labels"
				   tooltip="Labels to apply for this execution"
				   type="string"
				   checked="false" />

			<input name="reportPath" label="Report Path"
				   tooltip="Where to store reports, leave blank for defaults"
				   type="dir"
				   />
		</dialog>
	</ide>
</response>
</cfoutput>

