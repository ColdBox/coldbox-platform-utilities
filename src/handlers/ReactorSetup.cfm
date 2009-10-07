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
	<ide handlerfile="ReactorGenerator.cfm"> 
		<dialog width="550" height="400" title="ColdBox Reactor ORM Configurator" image="images/ColdBox_Icon.png">  
			<input name="projectName" label="Project Name" required="true"  type="string" 
				   tooltip="The reactor project name"
				   helpmessage="The database type used for metadata purposes" />
			<input name="dsnName" label="Datasource Name" required="true"  type="string" 
				   tooltip="Enter the name of the datasource to connect to"
				   helpmessage="Enter the name of the datasource to connect to" />
			<input name="dsnAlias" label="Datasource Alias" required="true"  type="string" 
				   tooltip="The alias for this datasource"
				   helpmessage="The alias for this datasource" />
			<input name="dsnType" label="Datasource Type" required="true"  type="list" 
				   tooltip="The database type"
				   helpmessage="The database type used for metadata purposes">
				<option value="mssql" />
				<option value="mysql" />
				<option value="mysql4" />
				<option value="postgresql" />
				<option value="oracle" />
				<option value="db2" />				
			</input>
				   
		</dialog>
	</ide>
</response>  
</cfoutput>

<cfcatch type="any">
	<cflog file="ColdBoxCFBuilder" text="#cfcatch.message#">
</cfcatch>
</cftry>


 