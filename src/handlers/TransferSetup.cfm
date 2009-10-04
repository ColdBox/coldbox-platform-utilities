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
	<ide handlerfile="TransferGenerator.cfm"> 
		<dialog width="500" height="400" title="ColdBox Transfer ORM Configurator" image="images/ColdBox_Icon.png">  
			<input name="dsnName" label="Datasource Name" required="true"  type="string" 
				   tooltip="Enter the name of the datasource to connect to"
				   helpmessage="Enter the name of the datasource to connect to" />
			<input name="dsnAlias" label="Datasource Alias" required="true"  type="string" 
				   tooltip="The alias for this datasource"
				   helpmessage="The alias for this datasource" />
			<input name="dsnType" label="Datasource Type" required="false"  type="list" 
				   tooltip="The database type"
				   helpmessage="The database type used for metadata purposes">
				<option value="mssql" />
				<option value="mysql" />
				<option value="mysql4" />
				<option value="postgresql" />
				<option value="oracle" />
				<option value="db2" />				
			</input>
			<input name="loadBeanInjector" label="Load Decorator Injector" type="boolean" checked="true"
				   tooltip="Load the Transfer Decorator Injector"
				   helpmessage="Load the Transfer Decorator Injector"
				   />
			<input name="diSetterInjection" label="Decorator Injector: Enable Setter Injections" type="boolean" 
				   checked="false" tooltip="Enable setter injection in the decorator injector"
				   helpmessage="Enable setter injection in the decorator injector"/>
			<input name="diStopRecursion" label="Decorator Injector: Stop Recursion Classes" type="string" 
				   default="" tooltip="The list of classes to stop recursion on (comma-delimmited)"
				   helpmessage="The list of classes to stop recursion on (comma-delimmited)"/>
		</dialog>
	</ide>
</response>  
</cfoutput>

<cfcatch type="any">
	<cflog file="ColdBoxCFBuilder" text="#cfcatch.message#">
</cfcatch>
</cftry>


 