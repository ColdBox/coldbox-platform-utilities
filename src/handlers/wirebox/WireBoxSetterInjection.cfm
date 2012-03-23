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
	<ide handlerfile="wirebox/WireBoxSetterInjectionGenerator.cfm">
		<dialog width="500" height="400" title="WireBox Setter Injection" image="includes/images/ColdBox_Icon.png">
			<input name="beanName" label="Bean Setter Name" type="string" required="true"
				   tooltip="The name of the bean to create a setter for: set{BeanName}"/>

			<input name="getter" label="Create Getter" type="boolean" checked="false"
				   tooltip="Generate a getter?" />

			<input name="Script" label="Script Based Function" type="boolean" checked="true"
				   tooltip="Choose whether to create the function in pure script or tag." />

			<input name="annotationType" label="Annotation Type" type="list" default="Inline"
				    tooltip="Generate the annotation as a comment or inline. Defaults to inline">
				<option value="Comment" />
				<option value="Inline" />
			</input>

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

		</dialog>
	</ide>
</response>
</cfoutput>