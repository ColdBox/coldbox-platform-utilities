<!-----------------------------------------------------------------------
********************************************************************************
Copyright Since 2005 ColdBox Framework by Luis Majano and Ortus Solutions, Corp
www.coldboxframework.com | www.luismajano.com | www.ortussolutions.com
********************************************************************************

Author      :	Sana Ullah & Luis Majano

All handlers receive the following:
- data 		  : The data parsed
- inputStruct : A parsed input structure
----------------------------------------------------------------------->
<cfheader name="Content-Type" value="text/xml">
<cfoutput>
<response status="success" type="default">
	<ide handlerfile="ModuleGenerator.cfm">
		<dialog width="600" height="450" title="ColdBox Module Wizard" image="includes/images/ColdBox_Icon.png">

			<input name="Title" label="Module Name" required="true"  type="string" tooltip="Enter a web safe module title (no spaces)" />
			<input name="Script" label="Script Based CFC" type="boolean" checked="false" tooltip="Choose whether to create the cfc in pure script or not." />
			<input name="Author" label="Module Author"  type="string" required="true" default="" tooltip="Enter Module Author" />
			<input name="AuthorURL" label="Module Author Url"  type="string" required="true" default="http://" tooltip="Enter Module Author website URL" />
			<input name="Description" label="Module description"  type="string" required="true" default="" tooltip="Enter module description" />
			<input name="Version" label="Module version"  type="string" required="true" default="1.0.0" tooltip="Enter module version" />
			<input name="CFMapping" label="CF Mapping"  type="string" required="false" default="" tooltip="Enter the ColdFusion mapping to create" />
			<input name="AutoMapModels" label="Auto Map Models" type="boolean" checked="true" tooltip="Auto Map Models Directory, defaults to true." />
			<input name="ModelNamespace" label="Model Namespace"  type="string" required="false" default="" tooltip="The namespace to use, if blank it uses the name of the module" />

		</dialog>
	</ide>
</response>
</cfoutput>

