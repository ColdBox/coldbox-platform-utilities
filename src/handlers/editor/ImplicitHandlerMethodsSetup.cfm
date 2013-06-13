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
	<ide handlerfile="editor/ImplicitHandlerMethodsGenerator.cfm"> 
		<dialog width="700" height="500" title="ColdBox Implicit Handler Wizard" image="includes/images/ColdBox_Icon.png">  
			
			<!--- Pre Handler --->
			<input name="preHandler" label="PreHandler()" type="boolean" checked="false" 
				   tooltip="Generate a preHandler action."
				   helpmessage="Generate a preHandler action." />
			
			<!--- Post Handler --->
			<input name="postHandler" label="PostHandler()" type="boolean" checked="false" 
				   tooltip="Generate a postHandler action."
				   helpmessage="Generate a postHandler action." />
			
			<!--- Around Handler --->
			<input name="aroundHandler" label="AroundHandler()" type="boolean" checked="false" 
				   tooltip="Generate a aroundHandler action."
				   helpmessage="Generate a aroundHandler action." />
			
			<!--- onMissingACtion --->
			<input name="onMissingAction" label="onMissingAction()" type="boolean" checked="false" 
				   tooltip="Generate an onMissingAction() method interceptor."
				   helpmessage="Generate an onMissingAction() method interceptor" />
			
			<!--- OnError --->
			<input name="onError" label="onError()" type="boolean" checked="false" 
				   tooltip="Generate an onError() method interceptor"
				   helpmessage="Generate an onError() method interceptor" />	   
			
			<!--- Script --->
			<input name="Script" label="Script Based Methods" type="boolean" checked="false" 
				   tooltip="Choose whether to create the methods in pure script or not."
				   helpmessage="Choose whether to create the methods in pure script or not." />
			
		</dialog>
	</ide>
</response>  
</cfoutput>

 