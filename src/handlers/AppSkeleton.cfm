<!-----------------------------------------------------------------------
********************************************************************************
Copyright Since 2005 ColdBox Framework by Luis Majano and Ortus Solutions, Corp
www.coldboxframework.com | www.luismajano.com | www.ortussolutions.com
********************************************************************************

Author      :	 Sana Ullah & Luis Majano
Date        :	08/01/2009
----------------------------------------------------------------------->

<!--- List of all coldbox Application Templates (Simple, Advance, Flex )--->
<cfdirectory action="list" directory="#expandPath('../skeletons')#" type="dir" name="appSkeletons" />

<cfheader name="Content-Type" value="text/xml">  
<cfoutput>  
<response status="success" type="default">  
	<ide handlerfile="ExpandAppSkeleton.cfm"> 
		<dialog width="450" height="450" title="ColdBox Application Generator" image="images/ColdBox_Icon.png">  
			<input name="ApplicationType" label="Select Application Type To Generate" type="list">
			<cfloop query="appSkeletons">
				<cfif left(appSkeletons.name,1) neq ".">
				<option value="#appSkeletons.name#" />
				</cfif>
			</cfloop> 
			</input>
			<input name="ApplicationCFCType" label="Application.cfc using inheritance" 
				   tooltip="Whether to create the Application.cfc with inheritance or not"
				   type="Boolean"
				   checked="true" /> 					
		</dialog>
	</ide>
</response>  
</cfoutput> 

