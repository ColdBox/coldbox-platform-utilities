<!-----------------------------------------------------------------------
Author 	 :	Sana Ullah
Date     :	August 1, 2009
Description :
---------------------------------------------------------------------->
<cfset data = xmlParse(ideeventinfo)>

<!--- List of all coldbox Application Templates (Simple, Advance, Flex )--->
<cfdirectory action="list" directory="#expandPath('../skeletons')#" type="dir" name="appSkeletons" />

<cfheader name="Content-Type" value="text/xml">  
<cfoutput>  
<response status="success" type="default">  
	<ide handlerfile="ExpandAppSkeleton.cfm"> 
		<dialog width="450" height="450" title="ColdBox Application Generator" image="images/ColdBox_Icon.png">  
			<input name="Select App Type" label="Select Application Type To Generate" type="list">
			<cfloop query="appSkeletons">
				<option value="#appSkeletons.name#" />
			</cfloop> 
			</input>					
		</dialog>
	</ide>
</response>  
</cfoutput> 

