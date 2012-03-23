<!-----------------------------------------------------------------------
********************************************************************************
Copyright Since 2005 ColdBox Framework by Luis Majano and Ortus Solutions, Corp
www.coldboxframework.com | www.luismajano.com | www.ortussolutions.com
********************************************************************************

Author      :	 Sana Ullah & Luis Majano
Date        :	08/01/2009
----------------------------------------------------------------------->
<cfscript>
// Get injection DSL Array
injectionDSL = controller.getUtility().getInjectionDSLArray();
</cfscript>
<cfheader name="Content-Type" value="text/xml">
<cfoutput>
<response status="success" type="default">
	<ide handlerfile="wirebox/WireBoxPropertyInjectionGenerator.cfm">
		<dialog width="500" height="400" title="WireBox Property Injection" image="includes/images/ColdBox_Icon.png">
			<input name="name" label="Property Name" type="string" required="true"
				   tooltip="The name of the property"/>

			<input name="Script" label="Script Based Property" type="boolean" checked="true"
				   tooltip="Choose whether to create the cfproperty in pure script or tag." />

			<input name="DSLNamespace" label="DSL Namespace" type="list" default="Choose one or Custom DSL Namespace">
				<option value="Choose one or Custom DSL Namespace" />
			<cfloop array="#injectionDSL#" index="dsl">
				<option value="#dsl#" />
			</cfloop>
			</input>

			<input name="DSLContext" label="DSL Context" type="string" required="false"
				   tooltip="The DSL context or remainder of the injection DSL (ex:MyModel). This value is concatenated to the DSL Namespace"/>

			<input name="customDSLNamespace" label="Custom DSL" type="string" required="false"
				   tooltip="The custom DSL namespace or use the DSL Namespace dropdown"/>

			<input name="scope" label="Injection Scope" type="string" required="false" default="variables"
				   tooltip="The name of the scope or structure to inject to. Defaults to variables scope"/>

		</dialog>
	</ide>
</response>
</cfoutput>