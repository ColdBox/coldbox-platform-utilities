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
<cfscript>
function getTypes(){
	if( NOT structKeyExists(application,"cache-forgebox-types") ){
		var forgeBox = createObject("component","coldboxExtension.model.util.ForgeBox").init();
		application["cache-forgebox-types"] = forgeBox.getTypes();
	}
	return application["cache-forgebox-types"];
}
// get Types
types = getTypes();
	
</cfscript>
<!--- Output --->
<cfheader name="Content-Type" value="text/xml">  
<cfoutput>  
<response status="success" type="default">  
	<ide handlerfile="forgebox/CategoryViewer.cfm"> 
		<dialog width="500" height="300" title="ColdBox ForgeBox Installer" image="includes/images/ColdBox_Icon.png">  
			
			<input name="Category" label="Category" type="list" default="#types.typeslug[1]#">
				<cfloop query="types">
					<option value="#types.typeslug#">#types.typename#</option>
				</cfloop> 
			</input>
			
			<input name="OrderBy" label="Order By" type="list" default="Popular">
				<option value="Popular" />
				<option value="New" />
				<option value="Recent" />
			</input>
						
		</dialog>
	</ide>
</response>  
</cfoutput> 

