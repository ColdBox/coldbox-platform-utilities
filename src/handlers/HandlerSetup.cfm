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
		<dialog width="700" height="450" title="ColdBox Event Handler Wizard" image="images/ColdBox_Icon.png">  
			<input name="Name" label="Enter handler name" required="true"  type="string" default="" tooltip="Enter handler cfc name without .cfc" />
			<input name="Description" label="Enter handler description"  type="string" default="" tooltip="Enter handler description" />					
			<input name="Script" label="Script Based CFC" type="boolean" checked="false" tooltip="Choose whether to create the cfc in pure script or not." />
			<input name="Actions" label="Actions (comma delimmitted)" type="string" default="index" tooltip="Enter a list of actions to generate" />
			<input name="GenerateViews" label="Generate views according to actions" type="boolean" tooltip="Generate views according to actions" />
			<input name="ViewsDirectory" label="Views Directory" type="projectdir" default="#data.event.ide.projectview.xmlattributes.projectlocation#/views" tooltip="Your views root directory" />
		</dialog>
	</ide>
</response>  
</cfoutput>

<cfcatch type="any">
	<cflog file="ColdBoxCFBuilder" text="#cfcatch.message#">
</cfcatch>
</cftry>


 