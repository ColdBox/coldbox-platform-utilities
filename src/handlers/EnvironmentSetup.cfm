<!-----------------------------------------------------------------------
********************************************************************************
Copyright Since 2005 ColdBox Framework by Luis Majano and Ortus Solutions, Corp
www.coldboxframework.com | www.luismajano.com | www.ortussolutions.com
********************************************************************************

Author      :	 Sana Ullah & Luis Majano
Date        :	08/01/2009
----------------------------------------------------------------------->
<cftry>
<cfset data = xmlParse(ideeventinfo)>

<cfheader name="Content-Type" value="text/xml">  
<cfoutput>  
<response status="success" type="default">  
	<ide handlerfile="EnvironmentGenerator.cfm"> 
		<dialog width="450" height="250" title="ColdBox Environment Control Configurator" image="images/ColdBox_Icon.png">  
			
			<input name="envName" label="Name of environment" type="string" 
				   tooltip="The unique name for this environment" required="true"
			/>
			<input name="envURLs" label="URL's for environment (comma-delimmited)" type="string" 
				   tooltip="The url parts that identify this environment. (comma-delimmited)" required="true"
			/>
			
		</dialog>
	</ide>
</response>  
</cfoutput>

<cfcatch type="any">
	<cflog file="ColdBoxCFBuilder" text="#cfcatch.message#">
</cfcatch>
</cftry>
