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

<!--- List of all coldbox Application Templates (Simple, Advance, Flex )--->
<cfdirectory action="list" directory="#expandPath( '../skeletons' )#" type="dir" name="appSkeletons" />

<!--- Output --->
<cfheader name="Content-Type" value="text/xml">
<cfoutput>
<response status="success" type="default">
	<ide handlerfile="AppSkeletonGenerate.cfm">
		<dialog width="500" height="300" title="ColdBox Application Generator" image="includes/images/ColdBox_Icon.png">
			<input name="ApplicationType" label="Application To Generate" type="list">
			<cfloop query="appSkeletons">
				<cfif left(appSkeletons.name,1) neq ".">
				<option value="#appSkeletons.name#" />
				</cfif>
			</cfloop>
			</input>
		</dialog>
	</ide>
</response>
</cfoutput>

