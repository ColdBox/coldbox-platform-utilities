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

<!--- Output --->
<cfheader name="Content-Type" value="text/xml">  
<cfoutput>  
<response status="success" type="default">  
	<ide handlerfile="ForgeBoxInstaller.cfm"> 
		<dialog width="500" height="200" title="ColdBox ForgeBox Installer" image="includes/images/ColdBox_Icon.png">  
			<input name="forgeBoxSlug" label="Enter the ForgeBox Entry Slug" 
				   tooltip="Enter the ForgeBox Entry Slug to instal"
				   type="string"
				   required="true" /> 					
		</dialog>
	</ide>
</response>  
</cfoutput> 

