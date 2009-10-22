<!-----------------------------------------------------------------------
Author 	 :	Sana Ullah
Date     :	August 1, 2009
Description :
---------------------------------------------------------------------->
<cftry>
<cfset data = xmlParse(ideeventinfo)>

<cfheader name="Content-Type" value="text/xml">  
<cfoutput>  
<response status="success" type="default">  
	<ide handlerfile="HandlerGenerator.cfm"> 
		<dialog width="700" height="500" title="ColdBox Event Handler Wizard" image="images/ColdBox_Icon.png">  
			<input name="Name" label="Enter handler name" required="true"  type="string" default="" tooltip="Enter handler cfc name without .cfc" />
			<input name="Description" label="Enter handler description"  type="string" default="" tooltip="Enter handler description" />					
			<input name="Script" label="Script Based CFC" type="boolean" checked="false" tooltip="Choose whether to create the cfc in pure script or not." />
			<input name="Actions" label="Actions (comma delimmitted)" type="string" default="index" tooltip="Enter a list of actions to generate" />
			
			<input name="GenerateViews" label="Generate views" type="boolean" tooltip="Generate views according to actions" />
			<input name="ViewsDirectory" label="Views Directory" type="projectdir" default="#data.event.ide.projectview.xmlattributes.projectlocation#/views" tooltip="Your views root directory" />
			
			<input name="GenerateTest" label="Generate Integration Test" type="boolean" tooltip="Generate the integration test component" />
			<input name="AppMapping" label="AppMapping" type="string" tooltip="The application mapping in the server. Location from the root"
				   helpmessage="The root location of the application on the server: ex: /MyApp" />
			<input name="TestsDirectory" label="Tests Directory" type="projectdir" default="#data.event.ide.projectview.xmlattributes.projectlocation#/test/integration" 
				   tooltip="Your integration tests directory" />
			
		</dialog>
	</ide>
</response>  
</cfoutput>

<cfcatch type="any">
	<cflog file="ColdBoxCFBuilder" text="#cfcatch.message#">
</cfcatch>
</cftry>


 